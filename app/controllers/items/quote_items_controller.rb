class Items::QuoteItemsController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @current_item = M2m::CurrentItem.for_part_number(@item.fpartno).first
    @quote_items = @item.quote_items.reverse_order.paginate(:all, :page => params[:page], :per_page => 10)
  end

  protected

    def model_class
      M2m::QuoteItem
    end
    
    def parent_object
      if @parent_object.nil?
        @items = M2m::Item.with_part_number(params[:item_id]).by_rev_desc
        @parent_object = @items.first
      end
      @parent_object
    end
    
end
