# Implements policy for choosing commissions.
# Used by commission reports and sales rep commission backlog.
class Sales::CommissionRateFinder
  attr_reader :commission_rates
  def initialize
    @commission_rates = Sales::CommissionRate.all
    @commission_rates_for_customer_and_item = {}
    @commission_rates_for_item = {}
    @commission_rates_for_customer = {}
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
  def get_rate(args)
    customer = args[:customer]
    part_number = args[:part_number]
    revision = args[:revision]
    invoice = args[:invoice]
    sales_order = args[:sales_order]
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
      return customer.sales_person_key, customer.commission_percentage, "Customer #{customer.customer_number}"
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
