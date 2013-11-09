require 'plutolib/stateless_delayed_report'

class Sales::RepReportRunner
  include Plutolib::StatelessDelayedReport

  # Sales::RepReportRunner.new.run_report
  def run_report
    if Date.current.month <= 3
      run_year(Date.current.advance(:years => -1))
    end
    run_year(Date.current)
  end

  # Sales::RepReportRunner.new.run_in_background!
  # Sales::RepReportRunner.new.run_year(Date.parse('2013-01-01'))
  def run_year(date)
    log "Running #{date.year}"
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    r = Sales::RepReport.new(:start_date => date.beginning_of_year, :end_date => date.end_of_year)
    r.to_xls File.join(basedir, "#{date.year} Rep Report.xls")
  end

end
