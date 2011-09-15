class SalesOrderItemsController < ApplicationController

  class SearchItem < M2m::SalesOrderItem
    attr_accessor :order_number
    attr_accessor :part_number
  end

  def index
    @search_item = SearchItem.new(params[:search])
    @sales_order_items = if @search_item.order_number.present?
      M2m::SalesOrderItem.order_number_like(@search_item.order_number)
    end
    if @search_item.part_number.present?
      @sales_order_items = if @sales_order_items.present?
        @sales_order_items.part_number_like(@search_item.part_number)
      else
        M2m::SalesOrderItem.part_number_like(@search_item.part_number)
      end
    end
    if @sales_order_items.present?
      @sales_order_items = @sales_order_items.paginate(:all, :page => params[:page],
                                                       :per_page => 20,
                                                       :order => 'soitem.fsono desc',
                                                       :include => :sales_order)
    end
  end

end
