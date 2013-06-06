require 'plutolib/stateless_delayed_report'

class Sales::FirstSaleReportRunner
  include Plutolib::StatelessDelayedReport

  # Sales::FirstSaleReportRunner.new.run_in_background!
  def run_report
    basedir = Rails.env.development? ? Rails.root : AppConfig.sales_dropbox_root
    Sales::FirstSaleReport.new.to_xls File.join(basedir, "LXD First Sale Report.xls")
  end

end
