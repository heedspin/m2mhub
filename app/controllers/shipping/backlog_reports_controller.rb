class Shipping::BacklogReportsController < M2mhubController
  filter_access_to_defaults

  def index
    @report = Shipping::BacklogReport.new(params[:search])
    @report.due_date = Date.current.next_week unless (@report.due_date.present? or params.member?(:search))
    @report.sort_order_id ||= Shipping::BacklogSortOrder.customer_so_pn.id
    @report.include_jobs ||= Shipping::IncludeJobs.none
    @report.run if params.member?(:search)
    @printing = (params[:commit] == 'Print')
    if @printing
      due_date = Date.parse(@report.due_date)
      @title = "#{AppConfig.short_name} Backlog #{due_date.to_s(:sales_date)}"
      @filename = [AppConfig.short_name.downcase, 'backlog', due_date.strftime("%m_%d_%y")].join('_') + '.pdf'
      @page_per_customer = @report.page_per_customer
      render_pdf :action => 'show.pdf.prince', :filename => @filename, :layout => false
    end
  end

  protected

    def model_class
      Shipping::BacklogReport
    end
end
