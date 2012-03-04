class Production::InventoryReportsController < ApplicationController
  filter_access_to_defaults

  def new
  end
  
  def create
    @report = Production::InventoryReport.new
    @report.run
    render :layout => false
  end

  protected
  
    def model_class
      Production::InventoryReport
    end

end
