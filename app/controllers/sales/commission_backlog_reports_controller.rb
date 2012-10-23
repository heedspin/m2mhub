class Sales::CommissionBacklogReportsController < M2mhubController
  filter_access_to_defaults :context => :sales_commission_backlog_reports

  def new
    @commission_backlog_report = build_object
  end

  def create
    @commission_backlog_report = build_object
    respond_to do |f|
      f.html do
        render :text => 'not implemented'
      end
      f.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@commission_backlog_report.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => @commission_backlog_report.to_xls
      end
    end
  end

  protected

    def model_class
      Sales::CommissionBacklogReport
    end
    
    def build_object
      if @build_object.nil?
        @build_object = model_class.new(params[:commission_backlog_report])
      end
      @build_object        
    end
    
end
