class Sales::Customers::OpportunitiesController < M2mhubController
  filter_access_to_defaults

  def index
    @customer = parent_object
    @opportunities = @customer.opportunities.by_last_update_desc.paginate(:page => params[:page], :per_page => 50)
  end
  protected

    def model_class
      Sales::Opportunity
    end
    
    def parent_object
      @parent_object ||= Sales::Customer.find(params[:sales_customer_id])
    end
end
