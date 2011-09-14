class ItemsController < ApplicationController

  class SearchItem < M2m::Item
  end

  def index
    @search_item = SearchItem.new(params[:item])
    if @search_item.fpartno.present?
      @items = M2m::Item.part_number_like(@search_item.fpartno).paginate(:all, :page => params[:page],
                                                                         :per_page => 20,
                                                                         :order => 'inmast.fpartno',
                                                                         :include => :vendors)
    end
  end

end
