class SalesOrdersController < ApplicationController
  filter_access_to_defaults

  def index
    @sales_orders = M2m::SalesOrder.open.paginate(:all, :page => params[:page], :per_page => 50, :order => 'forderdate desc, fsono desc')
  end

  def show
    @sales_order = current_object
    @previous_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono < ?', current_object.fsono], :order => 'fsono desc')
    @next_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono > ?', current_object.fsono], :order => 'fsono')
  end

  protected

    def model_class
      M2m::SalesOrder
    end
end
