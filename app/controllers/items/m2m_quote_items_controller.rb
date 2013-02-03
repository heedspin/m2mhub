class Items::M2mQuoteItemsController < M2mhubController
  filter_access_to_defaults :context => :items_m2m_quote_items

  def index
    @item = parent_object
    @quote_items = M2m::QuoteItem.for_item(@item).reverse_order.paginate(:page => params[:page], :per_page => 10)
  end

  protected

    def model_class
      M2m::QuoteItem
    end
    
    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
