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
    @start_date = val.is_a?(String) ? DateParser.parse(val) : val
  end
  
  def end_date=(val)
    @end_date = val.is_a?(String) ? DateParser.parse(val) : val
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
    xls_field('Post Date') { |r| r.post_date }
    xls_field('Customer') { |r| r.customer_name }
    xls_field('GL Account') { |r| r.gl_account }
    xls_field('Description') { |r| r.description }
    xls_field('Amount', dollar_format) { |r| r.amount.to_f.round(2) }
  end
  
  class ArdistOrGlTransaction
    attr_accessor :post_date, :customer_name, :gl_account, :description, :amount
    def initialize(t)
      @gl_account = t.gl_account_number.strip + ' ' + t.gl_account.description.strip
      @amount = t.value
      if t.is_a?(M2m::ArDistribution)
        @post_date = t.date
        @customer_name = t.customer.try(:company_name) || 'no name'
        d = []
        if t.ref_invoice?
          d.push "Invoice #{t.ref_id.to_i}"
          if t.invoice.sales_order_number.present?
            d.push "for SO #{t.invoice.sales_order_number.to_i}"
          end
          if t.invoice.number.present?
            d.push "shipper #{t.invoice.number.to_i}"
          end
        else
          d.push "#{t.ref_key.strip}: #{t.ref_id.strip}"
        end
        @description = d.join(' ')
      else
        @post_date = t.post_date
        d = []
        if t.journal_entry?
          d.push "Journal Entry"
        else
          d.push t.ref_key.strip
        end
        d.push "#{t.ref_id.to_i}: #{t.description.strip}"
        @description = d.join(' ')
      end
    end
  end
  
  def all_data
    end_date = self.end_date.advance(:days => 1)

    revenue_journal_entries = M2m::GlTransaction.post_dates(self.start_date, end_date).journal_entries.gl_category('R').not_balance_entries.not_adjustments.includes(:gl_account).all
    revenue_journal_entries = revenue_journal_entries.select { |je| Sales::SalesReport.is_revenue_account?(je.post_date, je.gl_account_number) }

    ar_distributions = M2m::ArDistribution.dates(self.start_date, end_date).non_zero.gl_category('R').includes(:gl_account).all
    ar_distributions = ar_distributions.select { |ar| Sales::SalesReport.is_revenue_account?(ar.date, ar.gl_account_number) }

    all = (ar_distributions + revenue_journal_entries).map { |t| ArdistOrGlTransaction.new(t) }
    all.sort_by(&:post_date)
  end
end
