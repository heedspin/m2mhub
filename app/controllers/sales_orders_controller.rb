class SalesOrdersController < ApplicationController
  filter_access_to_defaults
  
  def index
    @sales_orders = M2m::SalesOrder.open.paginate(:all, :page => params[:page], :per_page => 50, :order => 'forderdate desc, fsono desc')
  end
end