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
    @releases = @sales_order.filtered_releases(:include => :item)
    @previous_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono < ?', current_object.fsono], :order => 'fsono desc')
    @next_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono > ?', current_object.fsono], :order => 'fsono')
    @shipper_items = M2m::ShipperItem.for_sales_order(@sales_order).all(:include => :shipper)
    @shippers = @shipper_items.map do |i|
      # Optimization    
      i.shipper.items = @shipper_items.select { |si| si.shipper == i.shipper }
      i.shipper
    end
    @shippers = @shippers.uniq.sort_by { |s| s.ship_date }.reverse
  end

  protected

    def model_class
      M2m::SalesOrder
    end
end
