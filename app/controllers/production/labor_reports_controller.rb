class Production::LaborReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @report = M2m::LaborReport.new(params[:labor_report])
    @report.run
  end

  protected
  
    def model_class
      Production::LaborReport
    end

end
