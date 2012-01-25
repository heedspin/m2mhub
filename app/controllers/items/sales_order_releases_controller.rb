class Items::SalesOrderReleasesController < ApplicationController
  filter_access_to_defaults

  def index
    @item = parent_object
    @current_item = M2m::CurrentItem.for_part_number(@item.fpartno).first
    @sales_order_items = @item.sales_order_items.all(:include => :sales_order)
    @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).by_due_date_desc.paginate(:all, :page => params[:page], :per_page => 10)
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
      if @parent_object.nil?
        @items = M2m::Item.with_part_number(params[:item_id]).by_rev_desc
        @parent_object = @items.first
      end
      @parent_object
    end
    
end
