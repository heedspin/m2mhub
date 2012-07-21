require 'stateless_delayed_report'

class Sales::SalesReportRunner
  include StatelessDelayedReport

  # Sales::SalesReportRunner.new.recreate_all
  def recreate_all
    Sales::SalesReport.delete_all
    Sales::BookingsReport.delete_all
    self.update_12_months
    self.update_month
  end

  # Sales::SalesReportRunner.new.run_in_background!(:update_month)
  def update_month
    [Sales::SalesReport, Sales::BookingsReport].each do |klass|
      @klass = klass
      this_month = Date.current.beginning_of_month
      last_month = this_month.advance(:months => -1)
      [this_month, last_month].each do |month|
        run_month(month)
      end
    end
    self
  end

  # Sales::SalesReportRunner.new.run_in_background!(:update_12_months)
  def update_12_months
    end_date = Date.current.beginning_of_month.advance(:months => -2) # update_month handles recent months.
    [Sales::SalesReport, Sales::BookingsReport].each do |klass|
      @klass = klass
      start_date = nil
      if report = @klass.month(Date.current.advance(:months => -12)).first
        start_date = report.date
      else
        start_date = pick_epoch_date
      end
      date = start_date
      while date <= end_date
        run_month(date)
        date = date.advance(:months => 1)
      end
    end
    self
  end
  
  # Sales::SalesReportRunner.new.run_in_background!(:update_day_report)
  def update_day_report
    date = if Time.now.hour <= 6
      Date.current.advance(:days => -1)
    else
      Date.current
    end
    report = Sales::BacklogReport.date(date).first || Sales::BacklogReport.new(:date => date)
    report.run!
  end

  protected

    def run_month(month)
      unless report = @klass.month(month).first
        report = @klass.new(:report_time_period => ReportTimePeriod.month, :date => month)
      end
      log "Running #{month}"
      report.run!
    end

    def pick_epoch_date
      date = case @klass.name
      when 'Sales::SalesReport'
        M2m::Invoice.not_void.by_date.first.try(:date)
      when 'Sales::BookingsReport'
        M2m::SalesOrder.by_order_date.first.try(:order_date)
      end
      raise "Failed to find epoch for #{@klass.name}" unless date
      date.beginning_of_month
    end
end
