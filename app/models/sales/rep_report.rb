require 'plutolib/to_xls'

class Sales::RepReport
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

  def xls_sheet_name
    'Rep Report'
  end

  class RepRow
    attr_accessor :date, :vendor, :xnumbers, :opportunities, :quotes, :sample_orders, :tooling_orders, :production_orders, :commissions
    def initialize(vendor, date)
      @vendor = vendor || (raise "vendor required")
      @date = date || (raise "date required")
      @opportunities = []
      @quotes = []
      @sample_orders = []
      @tooling_orders = []
      @production_orders = []
      @commissions = 0.0
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
      @vendor.is_a?(String) && (@vendor != 'LXD')
    end
    def vendor_number
      @vendor.is_a?(M2m::Vendor) ? @vendor.vendor_number : nil
    end
  end

  def rep_row(vendor, date)
    @rep_rows ||= {}
    month = date.to_date.beginning_of_month
    @rep_rows[[vendor, month]] ||= RepRow.new(vendor, month)
  end

  # M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').vendor_account_number(AppConfig.commissions_gl_account_number).count
  # M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').invoice_number_like('Commission').count
  # puts M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').invoice_number_like('Commission').map { |vi| "fdtaxpoint: #{vi.fdtaxpoint.try(:to_date)} Inv: #{vi.finvdate.try(:to_date)} #{vi.vendor.name} #{vi.invoice_number}" }.join("\n")
  def load_commissions
    M2m::VendorInvoice.invoice_dates(self.start_date, self.end_date).invoice_number_like('Commission').each do |i|
      if i.date
        rep_row(i.vendor, i.date).commissions += i.amount
      end
    end
  end

  def xls_data
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date
    self.load_commissions
    Sales::Opportunity.not_deleted.start_dates(self.start_date, self.end_date).each do |o|
      vendor = if o.source.nil?
        'No Opportunity Source'
      elsif !o.source.sales_rep?
        'LXD'
      elsif o.sales_customer.nil?
        'From Rep, No Customer'
      elsif o.sales_customer.sales_territory.nil?
        'From Rep, Customer Has No Territory'
      elsif o.sales_customer.sales_territory.erp_vendor_id.nil? or o.sales_customer.sales_territory.vendor.nil?
        'From Rep, Territory Has No M2M Vendor'
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
    @rep_rows.values.sort
  end

  def xls_initialize
    xls_field('Month', xls_date_format) { |rr| rr.date }
    xls_field('Rep Name') { |rr| rr.vendor_name }
    xls_field('Commissions', xls_dollar_format) { |rr| rr.commissions }
    xls_field('Opportunities') { |rr| rr.opportunities.size }
    xls_field('Quotes') { |rr| rr.quotes.size }
    xls_field('Sample Orders') { |rr| rr.sample_orders.size }
    xls_field('Tooling Orders') { |rr| rr.tooling_orders.size }
    xls_field('Production Orders') { |rr| rr.production_orders.size }
    xls_field('X Numbers') { |rr| rr.is_error_bucket? ? rr.opportunities.map(&:xnumber).join(', ') : '' }
  end

end
