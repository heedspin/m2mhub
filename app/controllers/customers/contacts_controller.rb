class Customers::ContactsController < ApplicationController
  filter_access_to_defaults

  def index
    @customer = M2m::Customer.find(params[:customer_id])
    @contacts = @customer.contacts
  end
  protected

    def model_class
      M2m::SalesOrder
    end
end
