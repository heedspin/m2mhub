class SalesOrdersController < ApplicationController
  filter_access_to_defaults

  def index
    @sales_orders = M2m::SalesOrder.open.paginate(:all, :page => params[:page], :per_page => 50, :order => 'forderdate desc, fsono desc')
  end

  def show
    @sales_order = current_object
  end

  protected

    def model_class
      M2m::SalesOrder
    end
end
