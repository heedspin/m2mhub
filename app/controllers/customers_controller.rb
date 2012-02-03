class CustomersController < ApplicationController
  filter_access_to_defaults

  def index
    if (@search_term = params[:term]).present?
      autocomplete_index
    else
      search_index
    end
  end
  
  def new
    @customer = M2m::Customer.new(params[:m2m_customer])
    @customer.contacts.build
  end
  
  def create
    @customer = M2m::Customer.new(params[:m2m_customer])
    if @customer.save
      redirect_to customer_url(@customer.id)
    else
      render :action => 'new'
    end
  end
  
  def autocomplete_index
    # Autocomplete path.
    @customers = M2m::Customer.name_like(@search_term).by_name.all(:select => 'slcdpmx.fcompany', :limit => 10)
    names = @customers.map(&:name)
    # if params[:new_prompt] == '1'
    #   names.push "Create New: #{@search_term}"
    # end
    render :json => names
  end
  
  def search_index
    @search = M2m::Customer.new(params[:search])
    # For who knows what reason, a new customer comes out with a name = " ".
    if @search.fcompany
      @search.fcompany = @search.fcompany.strip
    end
    if @search.fcompany.present?
      @customers = M2m::Customer.name_like(@search.fcompany.strip).paginate(:all, :page => params[:page], :per_page => 50, :order => 'fcompany')
    end
    if @customers and (@customers.size == 1)
      redirect_to customer_url(@customers.first.fcustno)
    else
      @customer_names = M2m::Customer.all_names
    end
  end

  def show
    @customer = current_object
    @total_sales_orders = @customer.sales_orders.count
    @sales_orders = @customer.sales_orders.by_order_number_desc.all(:include => :releases, :limit => 5)
    @total_quotes = @customer.quotes.count
    @quotes = @customer.quotes.by_quote_number_desc.all(:include => :items, :limit => 1)
    # @previous_customer = M2m::Customer.find(:first, :conditions => ['fcompany < ?', current_object.fcompany], :order => 'fcompany desc')
    # @next_customer = M2m::Customer.find(:first, :conditions => ['fcompany > ?', current_object.fcompany], :order => 'fcompany')
  end

  protected

    def model_class
      M2m::Customer
    end
end
