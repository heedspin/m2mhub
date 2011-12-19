class Quality::QualityDashboardController < ::ApplicationController
  filter_access_to_defaults
  
  def index
    start_date = Date.current.advance(:days => -30)
    @rma_report = Quality::RmaReport.new(:start_date => start_date)
    @rma_report.run
    @otd_report = Quality::CustomerOtdReport.new(:start_date => start_date)
    @otd_report.run
    @credit_memo_report = Quality::CreditMemoReport.new(:start_date => start_date)
    @credit_memo_report.run
  end
end