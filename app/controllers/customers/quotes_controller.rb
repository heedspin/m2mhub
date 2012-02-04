class Customers::QuotesController < ApplicationController
  filter_access_to_defaults

  def index
    @customer = M2m::Customer.find(params[:customer_id])
    @quotes = @customer.quotes.by_quote_number_desc.paginate(:page => params[:page], :per_page => 10)
  end

  protected

    def model_class
      M2m::Quote
    end
end
