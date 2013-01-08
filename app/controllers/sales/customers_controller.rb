class Sales::CustomersController < M2mhubController
  filter_access_to_defaults

  def index
    if (@search_term = params[:term]).present?
      autocomplete_index
    else
      search_index
    end
  end

  def new
    @customer = build_object
  end

  def edit
    @customer = current_object
  end

  def create
    @customer = build_object
    if @customer.save
      redirect_to sales_customer_url(@customer)
    else
      render :action => 'new'
    end
  end

  def update
    @customer = current_object
    if @customer.update_attributes(params[:sales_customer])
      redirect_to sales_customer_url(@customer)
    else
      render :action => 'edit'
    end
  end

  def autocomplete_index
    # Autocomplete path.
    @customers = Sales::Customer.name_like(@search_term).by_name.select(:name).limit(20)
    names = @customers.map(&:name)
    if params[:new_prompt] == '1'
      names.push "Create New: #{@search_term}"
    elsif @customers.size == 0
      names.push 'No Results'
    end
    render :json => names
  end

  def search_index
    @search = Sales::Customer.new(params[:search])
    if params.member?(:search)
      s = Sales::Customer      
      s = s.name_like(@search.name.strip) if @search.name.present?
      s = s.sales_territory(@search.sales_territory)
      @customers = s.by_name.paginate(:page => params[:page], :per_page => 50)
    end
    if @customers and (@customers.size == 1)
      redirect_to sales_customer_url(@customers.first)
    end
  end

  def show
    @customer = current_object
    @opportunities = @customer.opportunities.status_open.by_last_update_desc.paginate(:page => params[:page], :per_page => 20)
  end

  def destroy
    @customer = current_object
    flash[:notice] = "Customer #{@customer.name} Deleted"
    @customer.destroy
    redirect_to sales_customers_url
  end

  protected

    def model_class
      Sales::Customer
    end
    
    def build_object
      @current_object ||= Sales::Customer.new(params[:sales_customer])
    end
end
