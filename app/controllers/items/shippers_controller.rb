class Items::ShippersController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @shippers = M2m::Shipper.for_item(@item).by_shipper_number_desc
    @total_shippers = @shippers.count
    if limit = params[:limit]
      @shippers = @shippers.all(:limit => limit.to_i)
      render :action => 'preview', :layout => false
    else
      @shippers = @shippers.includes(:items).paginate(:page => params[:page], :per_page => 10)
      M2m::Item.attach_items(@shippers.map(&:items).flatten)
    end
    M2m::ShipperItem.attach_sales_orders(@shippers)
  end

  protected

    def model_class
      M2m::Shipper
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
