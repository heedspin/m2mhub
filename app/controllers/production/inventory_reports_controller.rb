class Production::InventoryReportsController < ApplicationController
  filter_access_to_defaults

  def new
    @report = build_object
  end

  def create
    @report = build_object
    if @report.save
      @report.run_in_background!
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
