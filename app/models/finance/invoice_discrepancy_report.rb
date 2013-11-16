require 'plutolib/to_xls'

class Finance::InvoiceDiscrepancyReport
  include Plutolib::ToXls
  attr_accessor :start_date, :end_date

  def initialize(args)
    args ||= {}
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date
  end

  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end

  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end

  class Reconciler
    attr_accessor :invoice_items, :ar_distributions
    def initialize
      @invoice_items = []
      @ar_distributions = []
    end
    def add_invoice_item(ii)
      @invoice_items.push ii
    end
    def add_ar_distribution(ar)
      @ar_distributions.push ar
    end
    def total_invoice_amount
      @total_invoice_amount ||= @invoice_items.sum(&:amount)
    end
    def total_ar_amount
      @total_ar_amount ||= @ar_distributions.sum(&:amount)
    end
    def discrepancy?
      (total_ar_amount + total_invoice_amount) != 0
    end
    def invoice_number
      (@invoice_items + @ar_distributions).first.invoice_number
    end
    def invoice
      @invoice_items.first.try(:invoice)
    end
    def customer_name
      (@invoice_items + @ar_distributions).first.customer.try(:name)
    end
    def ar_gl_descriptions
      @ar_distributions.map(&:gl_account).uniq.map { |gl| gl.account_number.strip + ' ' + gl.description.strip }.join(', ')
    end
    def ar_post_dates
      @ar_distributions.map { |ar| ar.date.to_s(:number_date) }.uniq.join(', ')
    end
    def known_discrepancy?
      x = @ar_distributions.map { |ar| ar.gl_account.account_number }.uniq
      self.discrepancy? && (x.size == 1) && ['4009000', '4008000'].include?(x.first.strip)
    end
  end

  def xls_each_sheet(&block)
    by_invoice_number = {}
    M2m::InvoiceItem.item_types('S', 'F', 'M').where('aritem.ftotprice > 0').post_dates(self.start_date, self.end_date).not_void.scoped(:include => [:invoice, :customer]).each do |ii|
      (by_invoice_number[ii.invoice_number.strip] ||= Reconciler.new).add_invoice_item ii
    end
    ar_distributions = M2m::ArDistribution.dates(self.start_date, end_date).non_zero.gl_category('R').includes(:gl_account).all
    M2m::Customer.attach_customers(ar_distributions)
    ar_distributions.each do |ar|
      if Sales::SalesReport.is_revenue_account?(ar.date, ar.gl_account_number)
        (by_invoice_number[(ar.invoice_number || "ar #{ar.id}").strip] ||= Reconciler.new).add_ar_distribution ar
      end
    end
    puts "Processing #{by_invoice_number.size} invoices"
    fields = []
    fields.push(Plutolib::ToXls::Field.new('Invoice Post Date') { |r| r.invoice.try(:gl_date) })
    fields.push(Plutolib::ToXls::Field.new('Invoice Status') { |r| r.invoice.try(:status_name) })
    fields.push(Plutolib::ToXls::Field.new('AR Post Date') { |r| r.ar_post_dates})
    fields.push(Plutolib::ToXls::Field.new('Invoice Number') { |r| r.invoice_number })
    fields.push(Plutolib::ToXls::Field.new('SO') { |r| r.invoice.try(:sales_order_number) })
    fields.push(Plutolib::ToXls::Field.new('Customer') { |r| r.customer_name })
    fields.push(Plutolib::ToXls::Field.new('Total Invoice Amount') { |r| r.total_invoice_amount })
    fields.push(Plutolib::ToXls::Field.new('Total AR Amount') { |r| r.total_ar_amount })
    fields.push(Plutolib::ToXls::Field.new('Invoice Amounts') { |r| r.invoice_items.map(&:amount).join(', ') })
    fields.push(Plutolib::ToXls::Field.new('AR GL Accounts') { |r| r.ar_gl_descriptions })
    fields.push(Plutolib::ToXls::Field.new('AR Amounts') { |r| r.ar_distributions.map(&:amount).join(', ') })
    yield('Discrepancies', fields, by_invoice_number.values.select { |r| r.discrepancy? && !r.known_discrepancy? } )

    yield('Reconciled', fields, by_invoice_number.values.select { |r| !r.discrepancy? } )

    yield('Known Discrepancies', fields, by_invoice_number.values.select(&:known_discrepancy?))
  end

end
