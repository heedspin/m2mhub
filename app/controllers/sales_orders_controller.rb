require 'page_utils'
class SalesOrdersController < ApplicationController
  include PageUtils
  filter_access_to_defaults

  def index
    @sales_orders = M2m::SalesOrder.open.paginate(:all, :page => params[:page], :per_page => 50, :order => 'forderdate desc, fsono desc')
  end

  def show
    @sales_order = current_object
    if previous_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono < ?', current_object.fsono], :order => 'fsono desc')
      set_previous_page previous_sales_order.fsono, sales_order_url(previous_sales_order.fsono), previous_sales_order
    end
    if next_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono > ?', current_object.fsono], :order => 'fsono')
      set_next_page next_sales_order.fsono, sales_order_url(next_sales_order.fsono), next_sales_order
    end
  end

  protected

    def model_class
      M2m::SalesOrder
    end
end
