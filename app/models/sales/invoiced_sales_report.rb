require 'm2mhub/xls_report'

class Sales::InvoicedSalesReport
  include M2mhub::XlsReport
  attr_accessor :start_date, :end_date, :customer
  
  def initialize(args)
    args ||= {}
    self.customer = args[:customer]
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
  end
  
  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def filename
    # Time.now.strftime("%y%m%d") + '_' + 
    customer_name = self.customer.is_a?(M2m::Customer) ? self.customer.name : AppConfig.short_name
    name = "#{self.start_date.year} #{customer_name} Invoiced Sales"
    name.gsub(' ', '_').gsub(',','')
  end
  
  def sheet_name
    'Invoiced Sales'
  end
  
  def initialize_fields  
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    self.fields.push M2mhub::XlsReport::Field.new('Invoice Date') { |invoice_item| invoice_item.invoice.date }
    self.fields.push M2mhub::XlsReport::Field.new('Invoice Number') { |invoice_item| invoice_item.invoice_number }
    self.fields.push M2mhub::XlsReport::Field.new('Sales Order Number') { |invoice_item| invoice_item.sales_order_number }
    self.fields.push M2mhub::XlsReport::Field.new("#{AppConfig.short_name} Part Number") { |invoice_item| invoice_item.part_number }
    self.fields.push M2mhub::XlsReport::Field.new('Part Description') { |invoice_item| invoice_item.item.try(:description) }
    self.fields.push M2mhub::XlsReport::Field.new('Customer Part Number') { |invoice_item| clean_value invoice_item.customer_part_number }
    self.fields.push M2mhub::XlsReport::Field.new('Quantity') { |invoice_item| invoice_item.ship_quantity }
    self.fields.push M2mhub::XlsReport::Field.new('Unit Price', dollar_format) { |invoice_item| 
      invoice_item.unit_price.to_f.round(2)
    }
    self.fields.push M2mhub::XlsReport::Field.new('Invoice Amount', dollar_format) { |invoice_item| 
      invoice_item.amount.to_f.round(2) 
    }
    if self.customer == :all
      self.fields.push M2mhub::XlsReport::Field.new('Customer Number') { |invoice_item| invoice_item.invoice.customer_number }
      self.fields.push M2mhub::XlsReport::Field.new('Customer Name') { |invoice_item| invoice_item.invoice.customer_name }
      self.fields.push M2mhub::XlsReport::Field.new('Group') { |invoice_item| invoice_item.item.try(:fgroup).try(:strip) }        
      self.fields.push M2mhub::XlsReport::Field.new('Invoice Description') { |invoice_item| invoice_item.description }
    end
  end
  
  def all_data
    if @invoice_items.nil?
      raise ':start_date required' unless self.start_date
      raise ':end_date required' unless self.end_date
      raise ':customer required' unless self.customer
      @invoice_items = M2m::InvoiceItem.invoice_dates(self.start_date, self.end_date).not_void.scoped(:include => :invoice)
      @invoice_items = @invoice_items.customer(self.customer) if self.customer.is_a?(M2m::Customer)
      M2m::Item.attach_items(@invoice_items)
      M2m::SalesOrder.attach_sales_orders(@invoice_items)
    end
    @invoice_items
  end
end
