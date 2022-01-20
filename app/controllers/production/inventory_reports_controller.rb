class Production::InventoryReportsController < M2mhubController
  filter_access_to_defaults

  def show
    @report = current_object
    @customer_reports = @report.customer_reports.by_on_hand_desc.paginate(:page => params[:page], :per_page => 1)
    respond_to do |format|
      format.html
      format.json {
        result = if @report.delayed_job_status.in_progress?
          { :inprogress => true }
        else
          { :inprogress => false,
            :html => render_to_string(:partial => 'show.html.erb',
                                      :layout => false) }
        end
        render :json => result.to_json
      }
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :plain => @report.to_xls
      end
    end
  end

  def index
    @reports = Production::InventoryReport.by_date_desc.paginate(:page => params[:page], :per_page => 30)
  end

  def destroy
    @report = current_object
    @report.destroy
    flash[:notice] = "#{@report.report_name} deleted"
    redirect_to inventory_reports_url
  end

  protected

    def model_class
      Production::InventoryReport
    end

end
