class Quality::CustomerOtdReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @search = Quality::ReportSearch.new(params[:search])
    @search.year ||= Date.current.year.to_s
    @report = Quality::CustomerOtdReport.new(:start_date => @search.to_date)
    @report.run
  end
  
  protected
  
    def model_class
      Quality::CustomerOtdReport
    end

end
