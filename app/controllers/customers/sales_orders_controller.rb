class Customers::SalesOrdersController < ApplicationController
  filter_access_to_defaults

  def index
    @customer = M2m::Customer.find(params[:customer_id])
    @sales_orders = @customer.sales_orders.paginate(:all, :include => [:releases, :items], :page => params[:page], :per_page => 10, :order => 'forderdate desc, fsono desc')
    # Optimization:
    @sales_orders.each do |so| 
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
    end
  end
  protected

    def model_class
      M2m::SalesOrder
    end
end
