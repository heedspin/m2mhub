class Items::HistoryController < M2mhubController
  filter_access_to_defaults

  def show
    @item = parent_object
    # @sales_order_items = @item.sales_order_items.includes(:sales_order).to_a
    @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).by_due_date_desc.to_a
    @sales_order_items = M2m::SalesOrderItem.attach_to_releases_with_item(@sales_order_releases, @item)
    @sales_order_releases.each do |r|
      if i = @sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
        r.item = i
        r.sales_order = i.sales_order
        i.item = @item
      end
    end
    @purchase_order_items = M2m::PurchaseOrderItem.for_item(@item).status_open.includes(:purchase_order).to_a
    @material_availability_report = MaterialAvailabilityReport.new( :item => @item,
                                                                    :sales_order_releases => @sales_order_releases,
                                                                    :purchase_order_items => @purchase_order_items,
                                                                    :show_history => true )
  end
  
  protected

    def current_object
      M2m::Item.new
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end

end
