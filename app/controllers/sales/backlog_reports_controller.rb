class Sales::BacklogReportsController < M2mhubController
  filter_access_to_defaults :context => :backlog_reports

  def show
    @backlog_report = current_object
    M2m::Item.attach_items(@backlog_report.releases)
  end
  
  protected
  
    def model_class
      Sales::BacklogReport
    end
end
