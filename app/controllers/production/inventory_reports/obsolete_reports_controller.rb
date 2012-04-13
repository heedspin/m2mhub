class Production::InventoryReports::ObsoleteReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @inventory_report = parent_object
    @item_reports = @inventory_report.item_reports.by_latest_activity.scoped(:include => :customer_report).paginate(:page => params[:page], :per_page => 50)
  end
  
  protected

    def model_class
      Production::InventoryReportCustomer
    end

    def parent_object
      @parent_object ||= Production::InventoryReport.find(params[:inventory_report_id])
    end

end
