class Sales::SalesEventsController < M2mhubController
  filter_access_to_defaults :context => :sales_events

  class Search < Sales::Opportunity
    attr_accessor :sales_territory_id
    attr_accessor :for_sales_rep
    def for_sales_rep=(val)
      @for_sales_rep = val.is_a?(TrueClass) || (val == '1')
    end
    
    def initialize(args)
      super(args)
      self.end_date ||= Date.current
      self.start_date ||= self.end_date.beginning_of_month
    end
  end
  
  def index
    @search = Search.new(params[:search])
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
