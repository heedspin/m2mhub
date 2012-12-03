class Sales::BacklogReportsController < M2mhubController
  filter_access_to_defaults :context => :backlog_reports

  def show
    @backlog_report = current_object
    M2m::Item.attach_items(@backlog_report.releases)

    respond_to do |format|
      format.html
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@backlog_report.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => @backlog_report.to_xls
      end
    end
  end
  
  protected
  
    def model_class
      Sales::BacklogReport
    end
end
