class Quality::CustomerOtdReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = Quality::CustomerOtdReport.new
    @report.run
  end
  
  protected
  
    def model_class
      Quality::CustomerOtdReport
    end

end
