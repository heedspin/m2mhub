class Production::WorkCenterLoadReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = Production::WorkCenterLoadReport.new(:batch_name => '**default**')
    @report.run
  end

  protected
  
    def model_class
      Production::WorkCenterLoadReport
    end

end
