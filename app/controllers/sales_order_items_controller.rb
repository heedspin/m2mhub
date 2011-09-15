class SalesOrderItemsController < ApplicationController

  class SearchItem < M2m::SalesOrderItem
  end

  def index
    @search_item = SearchItem.new(params[:search])
    if @search_item.customer_part_number.present?
      @sales_order_items = M2m::SalesOrderItem.customer_part_number_like(@search_item.customer_part_number).paginate(:all, :page => params[:page],
                                                                                                                     :per_page => 20,
                                                                                                                     :order => 'soitem.fsono desc',
                                                                                                                     :include => :sales_order)
    end
  end

end
