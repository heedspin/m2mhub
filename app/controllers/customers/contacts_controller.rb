class Customers::ContactsController < ApplicationController
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
      @parent_object ||= M2m::Customer.find(params[:customer_id])
    end
end
