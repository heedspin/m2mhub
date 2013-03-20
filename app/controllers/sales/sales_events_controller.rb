class Sales::SalesEventsController < M2mhubController
  filter_access_to_defaults :context => :sales_events

  def index
    @search = Sales::SalesEvent::Search.new(params[:search])
    @sales_events = Sales::SalesEvent.search(@search).sort_by(&:date).reverse
    respond_to do |format|
      format.html
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"LXD_Sales_Events.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => Sales::SalesEvent::Export.new(@sales_events).to_xls
      end
    end
  end

end
