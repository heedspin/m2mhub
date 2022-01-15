class Sales::InvoicedSalesReportsController < M2mhubController
  filter_access_to_defaults :context => :invoiced_sales_reports
  # filter_access_to :create, :new, { :load_method => :build_object, :attribute_check => false }

  def new
    @report = build_object
  end

  def create
    @report = build_object
    respond_to do |f|
      f.html do
        render :plain => 'not implemented'
      end
      f.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :plain => @report.to_xls
      end
    end
  end

  protected

    def model_class
      Sales::InvoicedSalesReport
    end
    
    def build_object
      if @build_object.nil?
        @build_object = Sales::InvoicedSalesReport.new((params[:report] || {}).merge(:customer => :all))
        @build_object.start_date ||= Date.current.beginning_of_year
        @build_object.end_date ||= Date.current.end_of_year
      end
      @build_object        
    end
end
