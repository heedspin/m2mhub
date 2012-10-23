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
      cd.commission_percentage.present? ? (cd.commission_percentage / 100).to_f.round(2) : 0.0
    }
    xls_field('Total Commission', dollar_format) { |cd|
      cd.commission_percentage.present? ? ((cd.commission_percentage / 100) * cd.invoice_item.amount).to_f.round(2) : 0.0
    }
    xls_field('Commission Reason') { |cd| cd.commission_reason }
  end

  CommissionData = Struct.new(:invoice_item, :sales_person_name, :commission_percentage, :commission_reason)

  def xls_data
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date

    @invoice_items = M2m::InvoiceItem.invoice_dates(self.start_date, self.end_date).not_void.scoped(:include => [:invoice, :customer])
    M2m::Item.attach_items(@invoice_items)
    M2m::SalesOrder.attach_sales_orders(@invoice_items)

    @finder = Sales::CommissionRateFinder.new
    @invoice_items.map do |invoice_item|
      name, percentage, reason = @finder.get_rate( :customer => invoice_item.customer,
                                                   :part_number => invoice_item.part_number,
                                                   :revision => invoice_item.revision,
                                                   :invoice => invoice_item.invoice,
                                                   :sales_order => invoice_item.sales_order )
      CommissionData.new(invoice_item, name, percentage, reason)
    end
  end
end
