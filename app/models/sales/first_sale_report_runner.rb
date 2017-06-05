# 02 1 * * * /var/www/lxdhub/script/runner.sh 'Sales::FirstSaleReportRunner.new.delay.run'
#
# Sales::FirstSaleReportRunner.new.delay.run
class Sales::FirstSaleReportRunner
  def run
    Sales::FirstSaleReport.new.to_xls File.join(AppConfig.lxd_server_temp, "LXD First Sale Report.xls")
  end
end
