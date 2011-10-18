class PurchaseOrderItemsController < ApplicationController
  filter_access_to_defaults

  def index
    item_part_number = params[:item]
    @purchase_order_items = M2m::PurchaseOrderItem.for_item(item_part_number).all(:include => :purchase_order)
    @purchase_order_items = @purchase_order_items.sort_by { |i| i.last_promise_date }.reverse
    render :action => 'index', :layout => false
  end

end
