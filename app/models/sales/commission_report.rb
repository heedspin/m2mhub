require 'plutolib/to_xls'

class Sales::CommissionReport
  include Plutolib::ToXls
  attr_accessor :start_date, :end_date
  
  def initialize(args)
    args ||= {}
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
  end
  
  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def xls_filename
    'commission_report'
  end
  
  def xls_sheet_name
    'Commission Report'
  end
  
  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    xls_field('Invoice Date') { |cd| cd.invoice_item.invoice.date }
    xls_field('Invoice Number') { |cd| cd.invoice_item.invoice_number }
    xls_field('Sales Order Number') { |cd| cd.invoice_item.sales_order_number }
    xls_field("#{AppConfig.short_name} Part Number") { |cd| cd.invoice_item.part_number }
    xls_field('Part Description') { |cd| cd.invoice_item.item.try(:description) }
    xls_field('Customer Part Number') { |cd| xls_clean cd.invoice_item.customer_part_number }
    xls_field('Quantity') { |cd| cd.invoice_item.ship_quantity }
    xls_field('Unit Price', dollar_format) { |cd| 
      cd.invoice_item.unit_price.to_f.round(2)
    }
    xls_field('Invoice Amount', dollar_format) { |cd| 
      cd.invoice_item.amount.to_f.round(2) 
    }
    xls_field('Customer Number') { |cd| cd.invoice_item.invoice.customer_number }
    xls_field('Customer Name') { |cd| cd.invoice_item.invoice.customer_name }
    xls_field('Group') { |cd| cd.invoice_item.item.try(:fgroup).try(:strip) }        
    xls_field('Invoice Description') { |cd| cd.invoice_item.description }
    xls_field('Sales Rep') { |cd| cd.sales_person_name }
    xls_field('Commission Rate') { |cd| 
      cd.commission_percentage && (cd.commission_percentage / 100) 
    }
    xls_field('Total Commission', dollar_format) { |cd| 
      cd.commission_percentage && (((cd.commission_percentage / 100) * cd.invoice_item.amount).to_f.round(2) )
    }
    xls_field('Commission Reason') { |cd| cd.commission_reason }
  end
  
  CommissionData = Struct.new(:invoice_item, :sales_person_name, :commission_percentage, :commission_reason)
  
  def all_data
    @commission_rates_for_customer_and_item = {}
    @commission_rates_for_item = {}
    @commission_rates_for_customer = {}
    self.commission_rates.each do |cr|
      if cr.customer_number.present? and cr.part_number.present?
        @commission_rates_for_customer_and_item[[cr.customer_number, cr.part_number]] = cr
      elsif cr.customer_number.present?
        @commission_rates_for_customer[cr.customer_number] = cr
      elsif cr.part_number.present?
        @commission_rates_for_item[cr.part_number] = cr
      end
    end
    
    if @invoice_items.nil?
      raise ':start_date required' unless self.start_date
      raise ':end_date required' unless self.end_date
      @invoice_items = M2m::InvoiceItem.invoice_dates(self.start_date, self.end_date).not_void.scoped(:include => [:invoice, :customer])
      M2m::Item.attach_items(@invoice_items)
      M2m::SalesOrder.attach_sales_orders(@invoice_items)
    end
    @invoice_items.map do |invoice_item|
      sales_person_name, commission_percentage, commission_reason = find_commission_rate(invoice_item)
      CommissionData.new(invoice_item, sales_person_name, commission_percentage, commission_reason)
    end
  end
  
  def commission_rates
    @commission_rates ||= Sales::CommissionRate.all
  end

  def commission_rate_for_customer_and_item(customer_number, part_number)
    @commission_rates_for_customer_and_item[[customer_number, part_number]]
  end
  
  def commission_rate_for_item(part_number)
    @commission_rates_for_item[part_number]
  end
  
  def commission_rate_for_customer(customer_number)
    @commission_rates_for_customer[customer_number]
  end
  
  def find_commission_rate(invoice_item)
    if invoice_item.customer_number.present? and invoice_item.part_number.present? and (cr = self.commission_rate_for_customer_and_item(invoice_item.customer_number, invoice_item.part_number))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for customer and item)"
    end
    if invoice_item.part_number.present? and (cr = self.commission_rate_for_item(invoice_item.part_number))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for item)"
    end
    if invoice_item.customer_number.present? and (cr = self.commission_rate_for_customer(invoice_item.customer_number))
      return cr.sales_person_name, cr.commission_percentage, "Commission Rate #{cr.id} (for customer)"
    end
    if invoice_item.invoice.sales_person.present?
      return invoice_item.invoice.sales_person, invoice_item.invoice.commission_percentage, "Invoice #{invoice_item.invoice_number}"
    end
    if invoice_item.sales_order and invoice_item.sales_order.sales_person.present?
      return invoice_item.sales_order.sales_person, invoice_item.sales_order.commission_percentage, "Sales Order #{invoice_item.sales_order_number}"
    end
    if invoice_item.customer and invoice_item.customer.sales_person_key.present?
      return invoice_item.customer.sales_person_key, invoice_item.customer.commission_percentage, "Customer #{invoice_item.customer_number}"
    end
    nil
  end
end
