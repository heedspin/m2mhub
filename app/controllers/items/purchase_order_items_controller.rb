class Items::PurchaseOrderItemsController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @purchase_order_items = @item.purchase_order_items.reverse_order.includes(:purchase_order).paginate(:page => params[:page], :per_page => 10)
  end
  
  protected

    def model_class
      M2m::PurchaseOrderItem
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
