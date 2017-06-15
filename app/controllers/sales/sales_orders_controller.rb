class Sales::SalesOrdersController < M2mhubController
  filter_access_to_defaults :context => :sales_orders

  def index
    @sales_orders = M2m::SalesOrder.includes(:releases, :items).paginate(:page => params[:page], :per_page => 50).order('somast.forderdate desc, somast.fsono desc')
    @sales_orders.each do |so|
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
      so.items.each { |i| i.attach_releases_from_sales_order(so) }
    end
    # M2m::SalesOrderRelease.attach_to_sales_orders(@sales_orders)
    # M2m::SalesOrderItem.attach_to_releases(@sales_orders.map(&:releases).flatten)
  end

  def show
    @sales_order = current_object
    # @releases = @sales_order.releases.select { |r| !r.master? }
    # M2m::SalesOrderItem.attach_to_releases(@releases)
    @sales_order.releases.each { |r| r.attach_items_from_sales_order(@sales_order) }
    @sales_order.items.each { |i| i.attach_releases_from_sales_order(@sales_order) }
    
    @previous_sales_order = M2m::SalesOrder.where(['fsono < ?', current_object.fsono]).order('somast.fsono desc').first
    @next_sales_order = M2m::SalesOrder.where(['fsono > ?', current_object.fsono]).order('somast.fsono').first
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
