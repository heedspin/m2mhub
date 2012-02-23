class Customers::InvoicedSalesReportsController < ApplicationController
  filter_access_to_defaults
  
  def new
    @customer = parent_object
    @report_date_range = ReportDateRange.new(params[:report])
    @report_date_range.start_date ||= Date.current.beginning_of_year
    @report_date_range.end_date ||= Date.current.end_of_year
  end

  def create
    @customer = parent_object
    report_params = params[:report] || {}
    @report = InvoicedSalesReport.new( :customer => parent_object,
                                       :start_date => report_params[:start_date],
                                       :end_date => report_params[:end_date] )
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
end
