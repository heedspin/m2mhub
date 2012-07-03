require 'stateless_delayed_report'

class Sales::SalesReportRunner
  include StatelessDelayedReport
  
  # Bookings
  # M2m::SalesOrderRelease.order_dates('2012-06-01', '2012-07-01').sum(:fnetprice).to_f
  #
  # InvTotal
  # M2m::Invoice.invoice_dates('2012-06-01', '2012-07-01').sum(:fnamount).to_f
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').receivables_and_credits.not_cash.non_zero.sum(:fnamount).to_f
  #
  # Invoiced Sales
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').gl_category('R').not_cash.non_zero.not_receivables_or_credits.sum(:fnamount).to_f * -1
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').gl_category('R').not_cash.non_zero.not_receivables_or_credits.all(:include => :gl_account).sum(&:value).to_f

  def run_report
    generate_invoiced_sales_report
  end
  
  def generate_invoiced_sales_report
    start_date = nil
    end_date = Date.current
    if most_recent = Sales::SalesReport.where(["sales_reports.date <= ?", Date.current]).order("sales_reports.date desc").first
      raise "Implement me!"
      # Test checksum up until this date.  Move backwards until it matches.
    end
    s = M2m::Invoice.not_void.by_date
    start_date ||= M2m::Invoice.not_void.by_date.first.try(:date)
    return unless start_date
    date = start_date
    previous_sales_report = Sales::SalesReport.for_date(start_date.advance(:days => -1))
    while date <= end_date
      sales_report = Sales::SalesReport.for_date(date).first || Sales::SalesReport.new(:date => date)
      sales_report.run(previous_sales_report)
      date = date.advance(:days => 1)
      previous_sales_report = sales_report
    end
  end
end
