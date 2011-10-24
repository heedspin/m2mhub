class PurchaseOrderItemsController < ApplicationController
  filter_access_to_defaults

  class SearchItem < M2m::PurchaseOrderItem
    set_primary_key :_disabled
    attr_accessor :filter_status
  end

  def index
    @search = SearchItem.new(:fpartno => params[:item], :filter_status => params[:status])
    @purchase_order_items = M2m::PurchaseOrderItem.filtered.for_item(@search.fpartno)
    if @search.filter_status.present?
      @purchase_order_items = @purchase_order_items.with_status(@search.filter_status)
    end
    @purchase_order_items = @purchase_order_items.all(:include => :purchase_order).sort_by { |i| i.last_promise_date }.reverse
    render :action => 'index', :layout => false
  end

end
