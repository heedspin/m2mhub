class QuoteItemsController < ApplicationController
  filter_access_to_defaults

  def index 
    @search_item_part_number = params[:item]
    @quote_items = M2m::QuoteItem.for_item(@search_item_part_number)
    if @search_status = M2m::Status.find_by_name(params[:status])
      @quote_items = @quote_items.with_status(@search_status)
    end
    @quote_items = @quote_items.all(:include => :quote)
    @quote_items = @quote_items.sort_by { |qi| [qi.quote.date, qi.item_number]}
    render :action => 'index', :layout => false
  end
end
