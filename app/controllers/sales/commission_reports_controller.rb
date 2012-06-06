class Sales::CommissionReportsController < M2mhubController
  filter_access_to_defaults :context => :sales_commission_reports

  def new
    @commission_report = build_object
  end

  def create
    @commission_report = build_object
    respond_to do |f|
      f.html do
        render :text => 'not implemented'
      end
      f.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@commission_report.filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => @commission_report.to_xls
      end
    end
  end

  protected

    def model_class
      Sales::CommissionReport
    end
    
    def build_object
      if @build_object.nil?
        @build_object = model_class.new(params[:commission_report])
        @build_object.start_date ||= Date.current.beginning_of_year
        @build_object.end_date ||= Date.current.end_of_year
      end
      @build_object        
    end
    
end
