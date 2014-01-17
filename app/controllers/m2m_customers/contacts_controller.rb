class M2mCustomers::ContactsController < M2mhubController
  filter_access_to_defaults

  def index
    @customer = parent_object
    @contacts = @customer.contacts
  end
  protected

    def model_class
      M2m::SalesOrder
    end
    
    def parent_object
      @parent_object ||= M2m::Customer.find(params[:m2m_customer_id])
    end
end
