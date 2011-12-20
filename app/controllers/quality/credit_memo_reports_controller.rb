class Quality::CreditMemoReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @search = Quality::ReportSearch.new(params[:search])
    @search.year ||= Date.current.year.to_s
    @report = Quality::CreditMemoReport.new(:start_date => @search.to_date)
    @report.run
  end

  protected
  
    def model_class
      Quality::CreditMemoReport
    end

end
