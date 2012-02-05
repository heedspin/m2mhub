class Items::SalesOrderReleasesController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @sales_order_items = @item.sales_order_items.includes(:sales_order)
    @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).by_due_date_desc.paginate(:page => params[:page], :per_page => 10)
    @sales_order_releases.each do |r|
      if i = @sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
        r.item = i
        r.sales_order = i.sales_order
        i.item = @item
      end
    end
  end
  protected

    def model_class
      M2m::SalesOrderRelease
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
