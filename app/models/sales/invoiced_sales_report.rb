require 'plutolib/to_xls'

class Sales::InvoicedSalesReport
  include Plutolib::ToXls
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
  
  def xls_filename
    # Time.now.strftime("%y%m%d") + '_' + 
    customer_name = self.customer.is_a?(M2m::Customer) ? self.customer.name : AppConfig.short_name
    name = "#{self.start_date.year} #{customer_name} Invoiced Sales"
    name.gsub(' ', '_').gsub(',','')
  end
  
  def xls_sheet_name
    'Invoiced Sales'
  end
  
  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    xls_field('Invoice Date') { |invoice_item| invoice_item.invoice.date }
    xls_field('Invoice Number') { |invoice_item| invoice_item.invoice_number }
    xls_field('Sales Order Number') { |invoice_item| invoice_item.sales_order_number }
    xls_field("#{AppConfig.short_name} Part Number") { |invoice_item| invoice_item.part_number }
    xls_field('Part Description') { |invoice_item| invoice_item.item.try(:description) }
    xls_field('Customer Part Number') { |invoice_item| xls_clean invoice_item.customer_part_number }
    xls_field('Quantity') { |invoice_item| invoice_item.ship_quantity }
    xls_field('Unit Price', dollar_format) { |invoice_item| 
      invoice_item.unit_price.to_f.round(2)
    }
    xls_field('Invoice Amount', dollar_format) { |invoice_item| 
      invoice_item.amount.to_f.round(2) 
    }
    if self.customer == :all
      xls_field('Customer Number') { |invoice_item| invoice_item.invoice.customer_number }
      xls_field('Customer Name') { |invoice_item| invoice_item.invoice.customer_name }
      xls_field('Group') { |invoice_item| invoice_item.item.try(:fgroup).try(:strip) }        
      xls_field('Invoice Description') { |invoice_item| invoice_item.description }
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
