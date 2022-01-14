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
    @start_date = DateParser.parse(val)
  end

  def end_date=(val)
    @end_date = DateParser.parse(val)
  end

  def xls_filename
    'commission_report'
  end

  def xls_sheet_name
    'Commission Report'
  end

  # Should not be needed for Ruby 2.x.
  # def xls_clean_string(txt)
  #   if RUBY_VERSION >= "1.9.3"
  #     txt
  #   else
  #     # \326
  #     txt.try :tr, "\x91-\x94\x9c\x9d\x80\212\326", "''\"\"\"\"'S"
  #   end
  # end

  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    xls_field('Invoice Date') { |cd| cd.invoice_item.invoice.date }
    xls_field('Invoice Number') { |cd| cd.invoice_item.invoice_number }
    xls_field('Sales Order Number') { |cd| cd.invoice_item.sales_order_number }
    xls_field("#{AppConfig.short_name} Part Number") { |cd| cd.invoice_item.part_number }
    xls_field('Part Description') { |cd| cd.invoice_item.item.try(:description) }
    xls_field('Customer Part Number') { |cd| cd.invoice_item.customer_part_number }
    xls_field('Customer PO') { |cd| cd.invoice_item.sales_order.try(:customer_po) }
    xls_field('Quantity') { |cd| cd.invoice_item.ship_quantity }
    xls_field('Unit Price', dollar_format) { |cd|
      cd.invoice_item.unit_price.to_f.round(2)
    }
    xls_field('Invoice Amount', dollar_format) { |cd|
      cd.invoice_item.amount.to_f.round(2)
    }
    xls_field('Customer Number') { |cd| cd.invoice_item.invoice.customer_number }
    xls_field('Customer Name') { |cd| cd.invoice_item.invoice.customer_name }
    xls_field('Customer State, Main') { |cd| cd.invoice_item.customer.work_state.strip }
    xls_field('Customer State, Ship-To') { |cd|
      cd.invoice_item.customer.addresses.all.select { |a| a.ship_to? && a.work_state.present? }.map { |a| a.work_state.strip }.uniq.sort.join(', ')
    }
    xls_field('Customer State, Sold-To') { |cd|
      cd.invoice_item.customer.addresses.all.select { |a| a.sold_to? && a.work_state.present? }.map { |a| a.work_state.strip }.uniq.sort.join(', ')
    }
    xls_field('Group') { |cd| cd.invoice_item.item.try(:fgroup).try(:strip) }
    xls_field('Invoice Description') { |cd| cd.invoice_item.description }
    xls_field('Sales Rep') { |cd| cd.sales_person_name }
    xls_field('Commission Rate') { |cd|
      cd.commission_percentage.present? ? (cd.commission_percentage / 100).to_f.round(3) : 0.0
    }
    xls_field('Total Commission', dollar_format) { |cd|
      cd.commission_percentage.present? ? ((cd.commission_percentage / 100) * cd.invoice_item.amount).to_f.round(3) : 0.0
    }
    xls_field('Commission Reason') { |cd| cd.commission_reason }
  end

  CommissionData = Struct.new(:invoice_item, :sales_person_name, :commission_percentage, :commission_reason)

  def xls_data
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date

    @invoice_items = M2m::InvoiceItem.invoice_dates(self.start_date, self.end_date.advance(:days => 1)).not_void.includes([:invoice, :customer])
    M2m::Item.attach_items(@invoice_items)
    M2m::SalesOrder.attach_sales_orders(@invoice_items)

    result = []
    @finder = Sales::CommissionRateFinder.new
    @invoice_items.map do |invoice_item|
      rates = @finder.get_rates( :customer => invoice_item.customer,
                                 :part_number => invoice_item.part_number,
                                 :revision => invoice_item.revision,
                                 :invoice => invoice_item.invoice,
                                 :sales_order => invoice_item.sales_order )
      rates.each do |sales_person, percentage, reason|
        sales_person_name = sales_person.is_a?(M2m::SalesPerson) ? sales_person.name : sales_person
        result.push CommissionData.new(invoice_item, sales_person_name, percentage, reason)
      end
    end
    result
  end
end
