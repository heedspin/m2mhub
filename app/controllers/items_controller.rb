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
    @total_sales_order_releases = @sales_order_releases.size

    @purchase_order_items = @item.purchase_order_items.open.all(:include => :purchase_order)
    @purchase_order_items = @purchase_order_items.sort_by { |i| i.last_promise_date }.reverse[0..4]
    @total_purchase_order_items = @item.purchase_order_items.count

    @material_availability_report = MaterialAvailabilityReport.new(@item, @sales_order_releases, @purchase_order_items)

    @sales_order_releases = @sales_order_releases[0..4]
    @purchase_order_items = @purchase_order_items[0..4]
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
