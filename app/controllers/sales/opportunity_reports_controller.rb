class Sales::OpportunityReportsController < M2mhubController
  filter_access_to_defaults

  def index
    @opportunity_report = Sales::OpportunityReport.new(:start_month => params[:start_month], :end_month => params[:end_month])
    @opportunity_report.run
  end

  protected

    def model_class
      Sales::OpportunityReport
    end
end
