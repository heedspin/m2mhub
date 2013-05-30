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
      if cr.customer_number.present? and cr.part_number.present?
        @commission_rates_for_customer_and_item[[cr.customer_number, cr.part_number, cr.revision]] = cr
      elsif cr.customer_number.present?
        @commission_rates_for_customer[cr.customer_number] = cr
      elsif cr.part_number.present?
        @commission_rates_for_item[[cr.part_number, cr.revision]] = cr
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
    if external_rep_rate = self.get_external_rep_rate(customer, part_number, revision, invoice, sales_order)
      result.push external_rep_rate
    end
    if internal_rates = self.get_internal_rates(part_number, revision, invoice, sales_order)
      result.concat internal_rates
    end
    result
  end
  
  class InternalCommissionConfig
    attr_accessor :ordered_after, :name
    def initialize(config)
      @name = config['name']
      @ordered_after = config['ordered_after']
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
  end
  
  def internal_commission_configs
    @internal_commission_configs ||= AppConfig.internal_commission_rates.map { |config| InternalCommissionConfig.new(config) }
  end
  
  def get_internal_rates(part_number, revision, invoice, sales_order)
    result = []
    if item = M2m::Item.part_number(part_number).first
      self.internal_commission_configs.each do |config|
        commission_percentage = config.commission_percentage_for(item.product_class)
        next unless commission_percentage > 0
        # This is LXD specific.  Sorry...
        first_invoice = M2m::Invoice.part_number_like(part_number[0..part_number.size-2]).customer(invoice.customer_number).by_date.first
        next unless first_invoice.date >= config.ordered_after
        result.push [config.name, commission_percentage.to_f, "First ordered #{first_invoice.date.to_s(:database)} on invoice #{first_invoice.number.strip}, #{item.product_class.name.strip}, #{commission_percentage}"]
      end
    end
    result
  end
  
  def get_external_rep_rate(customer, part_number, revision, invoice, sales_order)
    if customer.present? and part_number.present? and (cr = self.commission_rate_for_customer_and_item(customer, part_number, revision))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for customer and item)"
    end
    if part_number.present? and (cr = self.commission_rate_for_item(part_number, revision))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for item)"
    end
    if customer.present? and (cr = self.commission_rate_for_customer(customer))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for customer)"
    end
    if invoice and invoice.sales_person.present?
      return invoice.sales_person, invoice.commission_percentage, "Invoice #{invoice.number}"
    end
    if sales_order and sales_order.sales_person.present?
      return sales_order.sales_person, sales_order.commission_percentage, "Sales Order #{sales_order.order_number}"
    end
    if customer and customer.sales_person_key.present?
      return customer.sales_person_key, customer.sales_person.try(:commission_percentage), "Customer #{customer.customer_number}"
    end
    nil
  end

  def commission_rate_for_customer_and_item(customer, part_number, revision)
    @commission_rates_for_customer_and_item[[customer.customer_number, part_number, revision]]
  end

  def commission_rate_for_item(part_number, revision)
    @commission_rates_for_item[[part_number, revision]]
  end

  def commission_rate_for_customer(customer)
    @commission_rates_for_customer[customer.customer_number]
  end
end
