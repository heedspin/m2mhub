class SalesOrdersController < ApplicationController
  filter_access_to_defaults

  def index
    @sales_orders = M2m::SalesOrder.includes(:releases).paginate(:page => params[:page], :per_page => 50).order('somast.forderdate desc, somast.fsono desc')
    M2m::SalesOrderRelease.attach_to_sales_orders(@sales_orders)
    M2m::SalesOrderItem.attach_to_releases(@sales_orders.map(&:releases).flatten)
  end

  def show
    @sales_order = current_object
    @releases = @sales_order.releases.select { |r| !r.master? }
    M2m::SalesOrderItem.attach_to_releases(@releases)
    @previous_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono < ?', current_object.fsono], :order => 'somast.fsono desc')
    @next_sales_order = M2m::SalesOrder.find(:first, :conditions => ['fsono > ?', current_object.fsono], :order => 'somast.fsono')
    @shipper_items = M2m::ShipperItem.for_sales_order(@sales_order).includes(:shipper).all
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
    
    def current_object
      @current_object ||= M2m::SalesOrder.includes(:releases).find(params[:id])
    end
end
