class Sales::OpportunityReportsController < M2mhubController
  filter_access_to_defaults

  def index
    @opportunity_report = Sales::OpportunityReport.new
    @opportunity_report.run
  end

  protected

    def model_class
      Sales::OpportunityReport
    end
end
