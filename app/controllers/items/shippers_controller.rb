class Items::ShippersController < M2mhubController
  filter_access_to_defaults

  def index
    @item = parent_object
    @shippers = M2m::Shipper.for_item(@item).includes(:items).by_shipper_number_desc
    @total_shippers = @shippers.count
    if limit = params[:limit]
      @shippers = @shippers.limit(limit.to_i)
    else
      @shippers = @shippers.paginate(:page => params[:page], :per_page => 10)
    end
    @shippers = @shippers.to_a
    M2m::Item.attach_items(@shippers.map(&:items).flatten)
    M2m::ShipperItem.attach_sales_orders(@shippers)
    if limit
      render :action => 'preview', :layout => false
    end
  end

  protected

    def model_class
      M2m::Shipper
    end

    def parent_object
      @parent_object ||= M2m::Item.includes(:revisions).find(params[:item_id])
    end
    
end
