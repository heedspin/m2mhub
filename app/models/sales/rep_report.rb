require 'plutolib/to_xls'

class Sales::RepReport
  include Plutolib::ToXls
  attr_accessor :start_date, :end_date

  def initialize(args)
    args ||= {}
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date
    @revenue_sources = []
  end

  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end

  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end

  RevenueSource = Struct.new(:invoice_number, :item_number, :date, :amount)
  def add_revenue_source(thing)
    @revenue_sources.push RevenueSource.new(thing.description, nil, thing.post_date, thing.amount)
  end

  class RepRow
    attr_accessor :date, :vendor, :xnumbers, :opportunities, :quotes, :sample_orders, :tooling_orders, :production_orders, :commissions, :invoiced, :opportunity_value
    def initialize(vendor, date)
      @vendor = vendor || (raise "vendor required")
      @date = date || (raise "date required")
      @opportunities = []
      @quotes = []
      @sample_orders = []
      @tooling_orders = []
      @production_orders = []
      @commissions = 0.0
      @invoiced = 0.0
      @opportunity_value = 0
    end
    def vendor_name
      @vendor.is_a?(String) ? @vendor : @vendor.name
    end
    def sorted_vendor_name
      @vendor.is_a?(String) ? "ZZZZZZZZZZZ #{@vendor}" : @vendor.name
    end
    def <=>(rhs)
      [self.date, self.sorted_vendor_name] <=> [rhs.date, rhs.sorted_vendor_name]
    end
    def is_error_bucket?
      @vendor.is_a?(String) && (@vendor != AppConfig.short_name)
    end
    def vendor_number
      @vendor.is_a?(M2m::Vendor) ? @vendor.vendor_number : nil
    end
    def total_sales_orders
      @opportunities.sum(&:total_sales_orders)
    end
    def total_potential_value
      self.opportunities.sum { |o| o.amount || 0 }
    end
    def median_potential_value
      # http://stackoverflow.com/questions/14859120/calculating-median-in-ruby
      sorted = self.opportunities.map(&:amount).compact.sort
      if sorted.size == 0
        0
      elsif sorted.size == 1
        sorted.first
      else
        len = sorted.length
        (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
      end
    end
    def total_quotes
      self.opportunities.sum { |o| o.comments.all.detect { |c| c.comment_type.quote? } ? 1 : 0 }
    end
    def total_sample_orders
      self.opportunities.sum { |o| o.comments.all.select { |c| c.comment_type.sales_order? and c.win_type.try(:sample_order?) } ? 1 : 0 }
    end
    def total_tooling_orders
      self.opportunities.sum { |o| o.comments.all.select { |c| c.comment_type.sales_order? and c.win_type.try(:tooling_order?) } ? 1 : 0 }
    end
    def total_production_orders
      self.opportunities.sum { |o| o.comments.all.select { |c| c.comment_type.sales_order? and c.win_type.try(:production_order?) } ? 1 : 0 }
    end
  end

  def rep_row(vendor, date)
    month = date.to_date.beginning_of_month
    @rep_rows[[vendor, month]] ||= RepRow.new(vendor, month)
  end

  # M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').vendor_account_number(AppConfig.commissions_gl_account_number).count
  # M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').invoice_number_like('Commission').count
  # puts M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').invoice_number_like('Commission').map { |vi| "#{vi.finvdate.try(:to_date)} #{vi.vendor_number} - #{vi.vendor.name} #{vi.invoice_number}" }.join("\n")
  def load_commissions
    M2m::VendorInvoice.invoice_dates(self.start_date.advance(:months => 1), self.end_date.advance(:months => 1)).invoice_number_like('Commission').each do |i|
      if i.date
        vendor = if AppConfig.lxd_house_vendors.include?(i.vendor_number)
          AppConfig.short_name
        else
          i.vendor
        end
        rep_row(vendor, i.date.advance(:months => -1)).commissions += i.amount
      end
    end
  end

  def load_invoices
    invoice_items = M2m::InvoiceItem.item_types('S', 'F').where('aritem.ftotprice > 0').post_dates(self.start_date, self.end_date).not_void.scoped(:include => [:invoice, :customer])
    M2m::SalesOrder.attach_sales_orders(invoice_items)
    finder = Sales::CommissionRateFinder.new
    invoice_items.each do |invoice_item|
      self.add_revenue_source invoice_item
      rates = finder.get_rates( :customer => invoice_item.customer,
                                :part_number => invoice_item.part_number,
                                :revision => invoice_item.revision,
                                :invoice => invoice_item.invoice,
                                :sales_order => invoice_item.sales_order )
      rates.each do |sales_person, percentage, reason|
        if sales_person.is_a?(M2m::SalesPerson) and sales_person.vendor_number.present? and sales_person.vendor
          rep_row(sales_person.vendor, invoice_item.invoice.gl_date).invoiced += invoice_item.amount
        else
          rep_row(AppConfig.short_name, invoice_item.invoice.gl_date).invoiced += invoice_item.amount
        end
      end
    end
    true
  end

  def load_opportunities
    Sales::Opportunity.not_deleted.start_dates(self.start_date, self.end_date).includes(:comments).each do |o|
      vendor = if o.source.nil?
        'Error: No Opportunity Source'
      elsif !o.source.sales_rep?
        AppConfig.short_name
      elsif o.sales_customer.nil?
        'Error: No Customer'
      elsif o.sales_customer.sales_territory.nil?
        'Error: Customer Has No Territory'
      elsif o.sales_customer.sales_territory.erp_vendor_id.nil? or o.sales_customer.sales_territory.vendor.nil?
        'Error: Territory Has No M2M Vendor'
      else
        o.sales_customer.sales_territory.vendor
      end
      self.rep_row(vendor, o.start_date || o.created_at).opportunities.push o
      comments = o.comments.by_created.all.reverse
      if q = comments.detect { |c| c.comment_type.quote? }
        self.rep_row(vendor, q.created_at).quotes.push q
      end
      if order = comments.detect { |c| c.comment_type.sales_order? && c.win_type.try(:sample_order?) }
        self.rep_row(vendor, order.created_at).sample_orders.push order
      end
      if order = comments.detect { |c| c.comment_type.sales_order? && c.win_type.try(:tooling_order?) }
        self.rep_row(vendor, order.created_at).tooling_orders.push order
      end
      if order = comments.detect { |c| c.comment_type.sales_order? && c.win_type.try(:production_order?) }
        self.rep_row(vendor, order.created_at).production_orders.push order
      end
    end
  end

  def load_gl
    M2m::GlTransaction.post_dates(self.start_date, end_date).journal_entries.gl_category('R').not_balance_entries.not_adjustments.each do |je|
      if Sales::SalesReport.is_revenue_account?(je.post_date, je.gl_account_number)
        self.add_revenue_source Sales::InvoicedSalesReport::ArdistOrGlTransaction.new(je)
        self.rep_row(AppConfig.short_name, je.post_date).invoiced += je.value
      end
    end
    ar_distributions = M2m::ArDistribution.dates(self.start_date, end_date).non_zero.gl_category('R').includes(:gl_account).all
    M2m::Customer.attach_customers(ar_distributions)
    M2m::Invoice.attach_invoices(ar_distributions)
    ar_distributions.each do |ar|
      if Sales::SalesReport.is_revenue_account?(ar.date, ar.gl_account_number)
        self.add_revenue_source Sales::InvoicedSalesReport::ArdistOrGlTransaction.new(ar)
        vendor = ar.customer.try(:sales_person).try(:vendor) || AppConfig.short_name
        self.rep_row(vendor, ar.date).invoiced += ar.value
      end
    end
  end

  def xls_data
    @rep_rows = {}
    self.load_gl
    self.load_commissions
    self.load_opportunities
    @rep_rows.values.sort
  end

  def xls_initialize
    xls_field('Month', xls_date_format) { |rr| rr.date }
    xls_field('Rep Name') { |rr| rr.vendor_name }
    xls_field('Territory Income', xls_dollar_format) { |rr| rr.invoiced }
    xls_field('Commissions', xls_dollar_format) { |rr| rr.commissions }
    xls_field('Rep Revenue', xls_dollar_format) { |rr| rr.total_sales_orders }
    xls_field('Opportunity Value', xls_dollar_format) { |rr| rr.total_potential_value }
    xls_field('Median Opportunity Value', xls_dollar_format) { |rr| rr.median_potential_value }
    xls_field('Opportunities') { |rr| rr.opportunities.size }
    xls_field('Quotes') { |rr| rr.total_quotes }
    xls_field('Sample Orders') { |rr| rr.total_sample_orders }
    xls_field('Tooling Orders') { |rr| rr.total_tooling_orders }
    xls_field('Production Orders') { |rr| rr.total_production_orders }
    xls_field('X Numbers') { |rr| rr.is_error_bucket? ? rr.opportunities.map(&:xnumber).join(', ') : '' }
  end

  def xls_each_sheet(&block)
    yield('Rep Report', xls_fields, xls_data)
    fields = []
    fields.push(Plutolib::ToXls::Field.new('Invoice') { |rs| rs.invoice_number })
    fields.push(Plutolib::ToXls::Field.new('Item') { |rs| rs.item_number })
    fields.push(Plutolib::ToXls::Field.new('Date') { |rs| rs.date })
    fields.push(Plutolib::ToXls::Field.new('Amount', xls_dollar_format) { |rs| rs.amount })
    yield('Invoice Items', fields, @revenue_sources)
  end
end
