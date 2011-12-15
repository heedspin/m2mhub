# Usage: ./script/runner ./script/otd.rb
#
class CustomerOtdReportRunner
  def run
    report = CustomerOtdReport.new
    unless report.run
      puts "OTD Report failed"
      1
    else
      # puts "SO #{late_release.sales_order_number}. Qty #{late_release.order_quantity} #{late_release.days_late} days late. Due: #{late_release.due_date}, Shipped: #{late_release.last_ship_date}"
      
      report.ordered_months.each do |month|
        puts "#{month.date.to_s(:month_year)}: #{month.num_late_releases} late out of #{month.num_releases}"
      end
      0
    end
  end
end

exit CustomerOtdReportRunner.new.run
