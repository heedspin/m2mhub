class QualityController < ApplicationController
  filter_access_to_defaults
  
  def index
    start_date = Date.current.advance(:days => -30)
    @rma_report = RmaReport.new(:start_date => start_date)
    @rma_report.run
    @otd_report = CustomerOtdReport.new(:start_date => start_date)
    @otd_report.run
  end
end