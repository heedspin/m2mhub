class ItemsController < ApplicationController

  class SearchItem < M2m::Item
    set_primary_key :_disabled # Allows search[:fpartno] to be mass-assigned.
  end

  def index
    @search_item = SearchItem.new(params[:search])
    if @search_item.fpartno.present?
      @items = M2m::Item.part_number_like(@search_item.fpartno).paginate(:all, :page => params[:page],
                                                                         :per_page => 20,
                                                                         :order => 'inmast.fpartno',
                                                                         :include => :vendors)
    end
  end
  
  def show
    @item = current_object
    @sales_order_items = @item.sales_order_items.all(:order => 'soitem.fsono desc, soitem.fenumber', :include => :sales_order)
    @purchase_order_items = @item.purchase_order_items.all(:order => 'poitem.fpono desc, poitem.fitemno', :include => :purchase_order)
    @shippers = M2m::Shipper.for_item(@item).all(:order => 'shmast.fshipdate desc')
  end
  
  protected
  
    def model_class
      M2m::Item
    end
  
end
