class Production::InventoryReportsController < M2mhubController
  filter_access_to_defaults

  def new
    @report = build_object
  end

  def create
    @report = build_object
    if @report.save
      @report.delay.run_report
      redirect_to inventory_report_url(@report)
    else
      render :action => 'new'
    end
  end

  def show
    @report = current_object
    @customer_reports = @report.customer_reports.by_on_hand_desc.paginate(:page => params[:page], :per_page => 1)
    respond_to do |format|
      format.html
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => @report.to_xls
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
