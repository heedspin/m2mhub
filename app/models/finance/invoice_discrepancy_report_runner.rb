require 'plutolib/logger_utils'

class Finance::InvoiceDiscrepancyReportRunner
  include Plutolib::LoggerUtils
  # Finance::InvoiceDiscrepancyReportRunner.new.run_report
  def run_report
    if Date.current.month <= 3
      run_year(Date.current.advance(:years => -1))
    end
    run_year(Date.current)
  end

  # Finance::InvoiceDiscrepancyReportRunner.new.run_in_background!
  # Finance::InvoiceDiscrepancyReportRunner.new.run_year(DateParser.parse('2013-01-01'))
  def run_year(date)
    log "Running #{date.year}"
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    r = Finance::InvoiceDiscrepancyReport.new(:start_date => date.beginning_of_year, :end_date => date.end_of_year)
    r.to_xls File.join(basedir, "#{date.year} Invoice Discrepancy Report.xls")
  end

end
