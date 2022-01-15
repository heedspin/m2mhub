class M2mCustomers::ExportsController < M2mhubController
  filter_access_to_defaults :context => :m2m_customers

  def index
    @m2m_customer_export = M2mCustomer::Export.new
    respond_to do |format|
      format.html
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"#{@m2m_customer_export.xls_filename}.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :plain => @m2m_customer_export.to_xls
      end
    end
  end
end
