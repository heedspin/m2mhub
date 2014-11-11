require 'plutolib/to_xls'
require 'plutolib/stateless_delayed_report'

# Finance::VendorPaymentsReport.new(:start_date => '2012-01-01', :end_date => '2013-12-31').to_xls('2012_2013_smt_vendor_payments.xls')
class Finance::VendorPaymentsReport
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

  def xls_data
    M2m::VendorInvoice.not_void.invoice_dates(self.start_date, self.end_date.advance(:days => 1))
  end

  def xls_initialize
    xls_field('Invoice Date', xls_date_format) { |i| i.date }
    xls_field('Invoice Month') { |i| i.date.month }
    xls_field('Invoice Year') { |i| i.date.year }
    xls_field('Invoice Number') { |i| i.invoice_number }
    xls_field('Vendor Number') { |i| i.vendor_number }
    xls_field('Vendor Name') { |i| i.vendor_name }
    xls_field('Status') { |i| i.status }
    xls_field('Amount', xls_dollar_format) { |i| i.amount }
  end

  # Finance::VendorPaymentsReport::Runner.new.run_report
  # Finance::VendorPaymentsReport::Runner.new.run_in_background!
  class Runner
    include Plutolib::StatelessDelayedReport

    def run_report
      if Date.current.month <= 3
        run_year(Date.current.advance(:years => -1))
      end
      run_year(Date.current)
    end

    def run_year(date)
      log "Running #{date.year}"
      basedir = Rails.root
      # basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
      r = Finance::VendorPaymentsReport.new(:start_date => date.beginning_of_year, :end_date => date.end_of_year)
      r.to_xls File.join(basedir, "#{date.year} #{AppConfig.short_name} Vendor Payments Report.xls")
    end
  end

end
