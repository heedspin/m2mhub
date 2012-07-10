require 'stateless_delayed_report'

class Sales::SalesReportRunner
  include StatelessDelayedReport
  
  # Sales::SalesReportRunner.new.run_in_background!(:update_month)
  def update_month
    this_month = Date.current.beginning_of_month
    last_month = this_month.advance(:months => -1)
    [this_month, last_month].each do |month|
      run_month(month)
    end
  end
  
  # Sales::SalesReportRunner.new.run_in_background!(:update_12_months)
  def update_12_months
    start_date = nil
    end_date = Date.current.beginning_of_month.advance(:months => -2) # update_month handles recent months.
    if report = Sales::SalesReport.month(Date.current.advance(:months => -12)).first
      start_date = report.date
    else
      # Start over
      start_date = M2m::Invoice.not_void.by_date.first.try(:date).try(:beginning_of_month)
      return if start_date.nil?
    end
    date = start_date
    while date <= end_date
      run_month(date)
      date = date.advance(:months => 1)
    end
  end
  
  def update_year
    start_date = nil
    end_date = Date.current
    if most_recent = Sales::SalesReport.where(["sales_reports.date <= ?", Date.current]).by_date_desc.first
      start_date = most_recent.date.advance(:months => -1)
    end
    start_date ||= M2m::Invoice.not_void.by_date.first.try(:date) || Date.current
    date = start_date
    while date <= end_date
      sales_report = Sales::SalesReport.month(date).first || Sales::SalesReport.new(:date => date)
      sales_report.run(previous_sales_report)
      date = date.advance(:days => 1)
      previous_sales_report = sales_report
    end
  end
  
  protected
  
    def run_month(month)
      unless report = Sales::SalesReport.month(month).first
        report = Sales::SalesReport.new(:report_time_period => ReportTimePeriod.month, :date => month)
      end
      log "Running #{month}"
      report.run!
    end
end
