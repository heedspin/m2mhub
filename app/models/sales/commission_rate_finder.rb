# Implements policy for choosing commissions.
# Used by commission reports and sales rep commission backlog.
class Sales::CommissionRateFinder
  attr_reader :commission_rates
  def initialize
    @commission_rates = Sales::CommissionRate.all
    @commission_rates_for_customer_and_item = {}
    @commission_rates_for_item = {}
    @commission_rates_for_customer = {}
    @commission_rates_for_item_group = {}
    self.commission_rates.each do |cr|
      part_number = Sales::CommissionRate.get_base_part_number(cr.part_number)
      if cr.customer_number.present? and cr.part_number.present?
        @commission_rates_for_customer_and_item[[cr.customer_number, part_number, cr.revision]] = cr
      elsif cr.customer_number.present?
        @commission_rates_for_customer[cr.customer_number] = cr
      elsif part_number.present?
        @commission_rates_for_item[[part_number, cr.revision]] = cr
      end
    end
  end
  def get_rates(args)
    result = []
    customer = args[:customer]
    part_number = args[:part_number]
    revision = args[:revision]
    invoice = args[:invoice]
    sales_order = args[:sales_order]
    if external_rep_rates = self.get_external_rep_rate(customer, part_number, revision, invoice, sales_order)
      result.concat external_rep_rates
    end
    # if internal_rates = self.get_internal_rates(customer, part_number, revision, invoice, sales_order)
    #   result.concat internal_rates
    # end
    result
  end
  
  class InternalCommissionConfig
    attr_accessor :ordered_after, :name
    def initialize(config)
      @name = config['name']
      @ordered_after = config['ordered_after']
      @skip_parts = Set.new((config['skip_parts'] || '').split(/[ ,]/).map(&:strip))
      @commission_percentages = {}
      config['rates'].each do |commission_percentage, product_classes|
        product_classes.split(',').map(&:strip).each do |product_class|
          @commission_percentages[product_class] = commission_percentage
        end
      end
    end
    
    def commission_percentage_for(product_class)
      @commission_percentages[product_class.name.strip] || 0
    end

    def skip_part?(part_number)
      @skip_parts.any? { |skip_me| part_number.starts_with?(skip_me) }
    end
  end
  
  def internal_commission_configs
    @internal_commission_configs ||= if AppConfig.internal_commission_rates
      AppConfig.internal_commission_rates.map { |config| InternalCommissionConfig.new(config) }
    else
      []
    end
  end

  def house_account?(customer_number)
    if @house_accounts.nil?
      @house_accounts = Set.new
      (AppConfig.internal_house_accounts || {}).each do |cn, key|
        @house_accounts.add(cn.to_i)
      end
    end
    @house_accounts.member?(customer_number.to_i)
  end
  
  def get_internal_rates(customer, part_number, revision, invoice, sales_order)
    result = []
    unless house_account?(customer.customer_number)
      if item = M2m::Item.part_number(part_number).first
        self.internal_commission_configs.each do |config|
          commission_percentage = config.commission_percentage_for(item.product_class)
          next unless commission_percentage > 0
          next if config.skip_part?(part_number)
          # This is LXD specific.  Sorry...
          first_invoice = M2m::Invoice.part_number_like(part_number[0..part_number.size-2]).customer(customer.customer_number).by_date.first
          if first_invoice.nil?
            result.push [config.name, commission_percentage.to_f, "Not yet shipped. #{item.product_class.name.strip}, Commission #{commission_percentage}%"]
          else
            next unless first_invoice.date >= config.ordered_after
            result.push [config.name, commission_percentage.to_f, "First ordered #{first_invoice.date.to_s(:database)} on invoice #{first_invoice.number.strip}, #{item.product_class.name.strip}, #{commission_percentage}"]
          end
        end
      end
    end
    result
  end

  def one_or_more_sales_person(commission_rate, reason)
    result = []
    split = commission_rate.second_sales_person.present?
    result.push [commission_rate.sales_person.name, commission_rate.commission_percentage, split ? 'Split: ' + reason : reason]
    if split
      result.push [commission_rate.second_sales_person.name, commission_rate.second_commission_percentage, 'Split: ' + reason]
    end
    result
  end
  
  def get_external_rep_rate(customer, part_number, revision, invoice, sales_order)
    if customer.present? and part_number.present? and (cr = self.commission_rate_for_customer_and_item(customer, part_number, revision))
      return one_or_more_sales_person(cr, "Commission Rate #{cr.id} (for customer and item)")
    end
    if part_number.present? and (cr = self.commission_rate_for_item(part_number, revision))
      return one_or_more_sales_person(cr, "Commission Rate #{cr.id} (for item)")
    end
    if customer.present? and (cr = self.commission_rate_for_customer(customer))
      return one_or_more_sales_person(cr, "Commission Rate #{cr.id} (for customer)")
    end
    if invoice and invoice.sales_person.present?
      return [[invoice.sales_person.name, invoice.commission_percentage, "Invoice #{invoice.invoice_number.strip}. Create rate!"]]
    end
    if sales_order and sales_order.sales_person.present?
      return [[sales_order.sales_person.name, sales_order.commission_percentage, "Sales Order #{sales_order.order_number}. Create rate!"]]
    end
    if customer and customer.sales_person_key.present?
      return [[customer.sales_person.name, customer.sales_person.try(:commission_percentage), "Customer #{customer.customer_number}. Create rate!"]]
    end
    return [['ERROR', 0, "No rate found. Create rate for #{customer.name}, #{part_number}."]]
  end

  def commission_rate_for_customer_and_item(customer, part_number, revision)
    @commission_rates_for_customer_and_item[[customer.customer_number, Sales::CommissionRate.get_base_part_number(part_number), revision]]
  end

  def commission_rate_for_item(part_number, revision)
    @commission_rates_for_item[[Sales::CommissionRate.get_base_part_number(part_number), revision]]
  end

  def commission_rate_for_customer(customer)
    @commission_rates_for_customer[customer.customer_number]
  end
end
