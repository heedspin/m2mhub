class ItemsController < M2mhubController
  filter_access_to_defaults

  def index
    if (@search_term = params[:term]).present?
      # Autocomplete path.
      @items = M2m::Item.part_number_like(@search_term).by_part_number.all(:select => 'inmastx.fpartno', :limit => 20)
      part_numbers = @items.map(&:part_number)
      if part_numbers.size == 0
        part_numbers.push 'No Results'
      end
      render :json => part_numbers
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
    @item = current_object
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
    @purchase_order_items = @purchase_order_items.sort_by { |i| i.safe_promise_date }
    @shippers_count = M2m::Shipper.for_item(@item).count
    @total_quote_items = M2m::QuoteItem.for_item(@item).count
    @quote_items = M2m::QuoteItem.for_item(@item).reverse_order.all(:limit => 3)
  end

  protected

    def model_class
      M2m::Item
    end

    def current_object
      @current_object ||= M2m::Item.includes(:revisions).find(params[:id])
    end

end
