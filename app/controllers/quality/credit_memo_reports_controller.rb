class Quality::CreditMemoReportsController < M2mhubController
  filter_access_to_defaults

  def new
    @search = Quality::ReportSearch.new(params[:search])
    @search.year ||= Date.current.year.to_s
    @report = Quality::CreditMemoReport.new(start_date: @search.start_date, end_date: @search.end_date)
    @report.run
  end

  protected
  
    def model_class
      Quality::CreditMemoReport
    end

end
