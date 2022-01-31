class Shipping::BacklogReportsController < M2mhubController
  filter_access_to_defaults

  def index
    search_params = params.fetch(:search,{}).permit!
    @report = Shipping::BacklogReport.new(search_params)
    @report.due_date ||= Date.current.next_week
    @report.sort_order_id ||= Shipping::BacklogSortOrder.customer_so_pn.id
    @report.include_jobs ||= Shipping::IncludeJobs.none
    @report.run if search_params.present?
    @printing = (params[:commit] == 'Print')
    if @printing
      @title = "#{AppConfig.short_name} Backlog #{@report.due_date.to_s(:sales_date)}"
      @filename = [AppConfig.short_name.downcase, 'backlog', @report.due_date.strftime("%m_%d_%y")].join('_') + '.pdf'
      @page_per_customer = @report.page_per_customer
      render_pdf :action => 'show.pdf.erb', :filename => @filename, :layout => false
    end
  end

  protected

    def model_class
      Shipping::BacklogReport
    end
end
