class Items::ShippersController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @current_item = M2m::CurrentItem.for_part_number(@item.fpartno).first
    @shippers = M2m::Shipper.for_item(@item.part_number).by_shipper_number_desc
    @total_shippers = @shippers.count
    if limit = params[:limit]
      @shippers = @shippers.all(:limit => limit.to_i)
      render :action => 'preview', :layout => false
    else
      @shippers = @shippers.paginate(:all, :page => params[:page], :per_page => 10)
    end
    M2m::ShipperItem.attach_sales_orders(@shippers)
  end

  protected

    def model_class
      M2m::Shipper
    end

    def parent_object
      if @parent_object.nil?
        @items = M2m::Item.with_part_number(params[:item_id]).by_rev_desc
        @parent_object = @items.first
      end
      @parent_object
    end
    
end
