require 'plutolib/stateless_delayed_report'

class Sales::CommissionReportRunner
  include Plutolib::StatelessDelayedReport

  # Sales::CommissionReportRunner.new.run_report
  def run_report
    if Date.current.month <= 6
      run_year(Date.current.advance(:years => -1))
    end
    run_year(Date.current)
  end

  # Sales::CommissionReportRunner.new.run_in_background!
  # Sales::CommissionReportRunner.new.run_year(DateParser.parse('2013-01-01'))
  def run_year(date)
    log "Running #{date.year}"
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    r = Sales::CommissionReport.new(:start_date => date.beginning_of_year, :end_date => date.end_of_year)
    r.to_xls File.join(basedir, "#{date.year} Commission Report.xls")
  end

  # Sales::CommissionReportRunner.new.run_range('2013-06-01', '2013-07-01')
  def run_range(start_date, end_date)
    start_date = DateParser.parse(start_date) unless start_date.is_a?(Date)
    end_date = DateParser.parse(end_date) unless end_date.is_a?(Date)
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    r = Sales::CommissionReport.new(:start_date => start_date, :end_date => end_date)
    r.to_xls File.join(basedir, 'Commission Report.xls')
  end

end
