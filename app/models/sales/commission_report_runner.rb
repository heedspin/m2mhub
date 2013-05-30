require 'plutolib/stateless_delayed_report'

class Sales::CommissionReportRunner
  include Plutolib::StatelessDelayedReport

  def run_report
    if Date.current.month <= 6
      run_year(Date.current.advance(:years => -1))
    end
    run_year(Date.current)
  end

  # Sales::CommissionReportRunner.new.run_in_background!
  def run_year(date)
    log "Running #{date.year}"
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    r = Sales::CommissionReport.new(:start_date => date.beginning_of_year, :end_date => date.end_of_year)
    r.to_xls File.join(basedir, "#{date.year} Commission Report.xls")
  end

end
