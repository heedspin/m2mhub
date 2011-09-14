class SalesOrdersController < ApplicationController
  filter_access_to_defaults

  def index
    @sales_orders = M2m::SalesOrder.paginate(:all, :include => [:releases, :items], :page => params[:page], :per_page => 50, :order => 'forderdate desc, fsono desc')
    # Optimization:
    @sales_orders.each do |so| 
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
    end
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
