class Quality::RmaReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = Quality::RmaReport.new
    @report.run
  end

  protected
  
    def model_class
      Quality::RmaReport
    end

end
