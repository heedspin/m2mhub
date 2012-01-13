class Production::WorkCenterLoadReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = Production::WorkCenterLoadReport.new(params[:search])
    @report.run
  end

  protected
  
    def model_class
      Production::WorkCenterLoadReport
    end

end
