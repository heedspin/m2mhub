class Customers::InvoicedSalesReportsController < M2mhubController
  filter_access_to_defaults
  
  def new
    @customer = parent_object
    @report = build_object
  end

  def create
    @customer = parent_object
    @report = build_object
    respond_to do |f|
      f.html do
        render :text => 'not implemented'
      end
      f.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => @report.to_xls
      end
    end
  end

  protected

    def model_class
      InvoicedSalesReport
    end

    def parent_object
      @parent_object ||= M2m::Customer.find(params[:customer_id])
    end
    
    def build_object
      if @build_object.nil?
        @build_object = InvoicedSalesReport.new((params[:report] || {}).merge(:customer => self.parent_object))
        @build_object.start_date ||= Date.current.beginning_of_year
        @build_object.end_date ||= Date.current.end_of_year
      end
      @build_object        
    end    
end
