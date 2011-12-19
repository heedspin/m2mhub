class Quality::CreditMemoReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = Quality::CreditMemoReport.new
    @report.run
  end

  protected
  
    def model_class
      Quality::CreditMemoReport
    end

end
