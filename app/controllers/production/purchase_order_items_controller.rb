class Production::PurchaseOrderItemsController < M2mhubController
  filter_access_to_defaults

  class Search < M2m::PurchaseOrderItem
    attr_accessor :status_id
  end

  def index
    @search = Search.new(params[:search])
    unless params.member?(:search)
      @search.status_id = M2m::Status.open.id
    end
    s = M2m::PurchaseOrderItem.filtered
    if @search.status_id.present?
      status = M2m::PurchaseOrderStatus.find(@search.status_id)      
      s = s.with_status(status)
      # if status.open?
      #   s = s.by_po_date_desc
      # else
        s = s.by_date_received_desc
      # end
    end
    if @search.inspection_required.present?
      s = s.inspection_required(@search.inspection_required)
    end
    @purchase_order_items = s.by_last_promised.includes(:purchase_order).paginate(:page => params[:page], :per_page => 50)
    M2m::Item.attach_items(@purchase_order_items)
  end
  
  protected

    def model_class
      M2m::PurchaseOrderItem
    end

end
