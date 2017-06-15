class Production::Vendors::PurchaseOrderItemsController < M2mhubController
  filter_access_to_defaults

  def index
    @vendor = parent_object
    @purchase_order_items = M2m::PurchaseOrderItem.filtered.vendor(@vendor)
    @total_purchase_order_items = @purchase_order_items.count
    @purchase_order_items = @purchase_order_items.rev_order.includes(:purchase_order).paginate(:page => params[:page], :per_page => 50)
  end
  
  protected

    def model_class
      M2m::PurchaseOrderItem
    end

    def parent_object
      @parent_object ||= M2m::Vendor.find(params[:vendor_id])
    end
    
end
