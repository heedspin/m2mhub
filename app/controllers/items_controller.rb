class ItemsController < ApplicationController
  filter_access_to_defaults

  class SearchItem < M2m::Item
    # Allows search[:fpartno] to be mass-assigned.
    set_primary_keys '_disabled_fpartno', '_disabled_frev'
  end

  def index
    @search_item = SearchItem.new(params[:search])
    if @search_item.fpartno.present?
      @items = M2m::Item.part_number_like(@search_item.fpartno).paginate(:all, :page => params[:page],
                                                                         :per_page => 20,
                                                                         :order => 'inmast.fpartno')
    end
  end

  def show
    @item = current_object

    @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).open.by_due_date_desc.all#(:include => [:sales_order, :item])
    M2m::SalesOrderItem.attach_to_releases(@sales_order_releases, @item)
    @total_sales_order_releases = M2m::SalesOrderRelease.for_item(@item).count

    @purchase_order_items = M2m::PurchaseOrderItem.for_item(@item).open.all(:include => :purchase_order)
    @total_purchase_order_items = M2m::PurchaseOrderItem.filtered.for_item(@item).count

    @material_availability_report = MaterialAvailabilityReport.new( :item => @item,
                                                                    :sales_order_releases => @sales_order_releases,
                                                                    :purchase_order_items => @purchase_order_items,
                                                                    :show_history => false )

    @sales_order_releases = @sales_order_releases.select { |s| s.status.open? }
    @purchase_order_items = @purchase_order_items.sort_by { |i| i.last_promise_date }
    @total_quote_items = @item.quote_items.count
    @shippers_count = M2m::Shipper.for_item(@item).count
    @quote_items = @item.quote_items.reverse_order.all(:limit => 3)
  end

  protected

    def model_class
      M2m::Item
    end

    def current_object
      if @current_object.nil?
        item_id = CGI::unescape(params[:id])
        @items = M2m::Item.with_part_number(item_id).by_rev_desc
        @current_object = @items.first
      end
      @current_object
    end

end
