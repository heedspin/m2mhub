class ItemsController < ApplicationController
  filter_access_to_defaults

  def index
    if (@search_term = params[:term]).present?
      # Autocomplete path.
      @items = M2m::Item.part_number_like(@search_term).by_part_number.all(:select => 'inmastx.fpartno', :limit => 20)
      render :json => @items.map(&:part_number)
    else
      @search = M2m::Item.new
      search_params = params[:search] || {}
      @search.fpartno = search_params['fpartno']
      if @search.fpartno.present?
        @items = M2m::Item.company_or_vendor_part_number_like(@search.fpartno).
          by_part_rev_desc.paginate(:page => params[:page], :per_page => 20)
      end
    end
  end

  def show
    unless @item = current_object
      # if @item_id.include?('/') and (part_no = @item_id.split('/').first) and (M2m::Item.with_part_number(part_no).count > 0)
      #   redirect_to
      #
      # end
      record_not_found
    else
      @sales_order_releases = M2m::SalesOrderRelease.for_item(@item).status_open.by_due_date_desc.all#(:include => [:sales_order, :item])
      M2m::SalesOrderItem.attach_to_releases_with_item(@sales_order_releases, @item)
      @total_sales_order_releases = M2m::SalesOrderRelease.for_item(@item).count

      @purchase_order_items = M2m::PurchaseOrderItem.for_item(@item).status_open.all(:include => :purchase_order)
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
  end

  protected

    def model_class
      M2m::Item
    end

    def current_object
      @current_object ||= M2m::Item.includes(:revisions).find(params[:id])
    end

end
