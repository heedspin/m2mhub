class Sales::ProFormaSalesReportsController < M2mhubController
  filter_access_to_defaults :context => :pro_forma_sales_reports

  def new
    # @report = build_object
    # @report.run
    @sales_orders = M2m::SalesOrder.status_open.prepayment_required.includes(:invoices).by_due_date
  end

  protected

    def model_class
      M2m::SalesOrder
    end
    
end
