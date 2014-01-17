class Production::PurchaseOrdersController < M2mhubController
  filter_access_to_defaults

  def show
    @purchase_order = current_object
  end
  
  protected

    def model_class
      M2m::PurchaseOrder
    end

end
