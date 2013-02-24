class Sales::Customers::QuotesController < M2mhubController
  filter_access_to_defaults

  def index
    @customer = parent_object
    @quotes = @customer.quotes.by_created_at_desc.paginate(:page => params[:page], :per_page => 50)
  end
  protected

    def model_class
      Sales::Quote
    end
    
    def parent_object
      @parent_object ||= Sales::Customer.find(params[:sales_customer_id])
    end
end
