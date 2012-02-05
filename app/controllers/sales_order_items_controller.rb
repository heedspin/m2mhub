class SalesOrderItemsController < ApplicationController
  filter_access_to_defaults

  class SearchItem < M2m::SalesOrderItem
    attr_accessor :order_number
    attr_accessor :part_number
  end

  def index
    @search = SearchItem.new(params[:search])
    @sales_order_items = if @search.order_number.present?
      M2m::SalesOrderItem.order_number_like(@search.order_number)
    end
    if @search.part_number.present?
      @sales_order_items = if @sales_order_items.present?
        @sales_order_items.part_number_like(@search.part_number)
      else
        M2m::SalesOrderItem.part_number_like(@search.part_number)
      end
    end
    if @sales_order_items.present?
      @sales_order_items = @sales_order_items.paginate(:page => params[:page],
                                                       :per_page => 20).order('soitem.fsono desc').includes(:sales_order)
    end
  end

end
