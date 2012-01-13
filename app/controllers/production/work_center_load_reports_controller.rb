class Production::WorkCenterLoadReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @range_report = Production::WorkCenterLoadReport.new(:batch_name => 'range')
    @range_report.run
    @default_report = Production::WorkCenterLoadReport.new(:batch_name => '**default**')
    @default_report.run
  end

  protected
  
    def model_class
      Production::WorkCenterLoadReport
    end

end
