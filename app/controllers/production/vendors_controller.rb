class Production::VendorsController < M2mhubController
  filter_access_to_defaults

  def show
    @vendor = current_object
    @purchase_order_items = M2m::PurchaseOrderItem.filtered.vendor(@vendor)
    @total_purchase_order_items = @purchase_order_items.count
    @purchase_order_items = @purchase_order_items.includes(:purchase_order => :vendor).reverse_order.limit(10)
  end
  
  def index
    if (@search_term = params[:term]).present?
      autocomplete_index
    else
      search_index
    end
  end
  
  def autocomplete_index
    @vendors = model_class.name_like(@search_term).by_name.all(:select => 'apvend.fcompany', :limit => 20)
    names = @vendors.map { |v| { :label => v.name, :value => v.name } }
    if names.size == 0
      names.push({:label => 'No Results', :value => 'No Results'})
    end
    render :json => names.to_json
  end

  def search_index
    @vendors = model_class.by_name.paginate(:page => params[:page], :per_page => 50)
  end

  protected

    def model_class
      M2m::Vendor
    end

end
