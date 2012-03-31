class Production::InventoryReports::CustomerReportsController < ApplicationController
  filter_access_to_defaults

  def index
    @inventory_report = parent_object
    @customer_reports = @inventory_report.customer_reports.by_on_hand_desc.paginate(:page => params[:page], :per_page => 50)
  end
  
  def show
    @inventory_report = parent_object
    @customer_report = current_object
    @item_reports = @customer_report.item_reports.by_on_hand_cost_desc.paginate(:page => params[:page], :per_page => 50)
    @next_customer_report = @inventory_report.customer_reports.by_on_hand_desc.with_less_onhand(@customer_report).first
    @prev_customer_report = @inventory_report.customer_reports.by_on_hand.with_more_onhand(@customer_report).first
  end

  protected

    def model_class
      Production::InventoryReportCustomer
    end

    def parent_object
      @parent_object ||= Production::InventoryReport.find(params[:inventory_report_id])
    end

end
