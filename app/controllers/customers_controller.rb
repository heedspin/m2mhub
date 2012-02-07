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
    @customer.contacts.build.primary = true
  end
  
  def edit
    @customer = current_object
    @customer.strip_strings
    @customer.contacts.map(&:strip_strings)
  end

  def create
    @customer = M2m::Customer.new(params[:m2m_customer])
    contact = @customer.contacts.to_a.first
    @customer.transaction do
      if @customer.save
        # Tie the contact to the customer.
        if contact
          contact.primary = true
          contact.fcsourceid = @customer.id
          contact.save
        end
        redirect_to customer_contacts_url(@customer)
      else
        render :action => 'new'
      end
    end
  end
  
  def update
    @customer = current_object
    if @customer.update_attributes(params[:m2m_customer])
      redirect_to customer_contacts_url(@customer)
    else
      render_action :action => 'edit'
    end
  end

  def autocomplete_index
    # Autocomplete path.
    @customers = M2m::Customer.name_like(@search_term).by_name.all(:select => 'slcdpmx.fcompany', :limit => 10)
    names = @customers.map(&:name)
    if params[:new_prompt] == '1'
      names.push "Create New: #{@search_term}"
    end
    render :json => names
  end

  def search_index
    @search = M2m::Customer.new(params[:search])
    # For who knows what reason, a new customer comes out with a name = " ".
    if @search.fcompany
      @search.fcompany = @search.fcompany.strip
    end
    if @search.fcompany.present?
      @customers = M2m::Customer.name_like(@search.fcompany.strip).paginate(:page => params[:page], :per_page => 50).order('fcompany')
    end
    if @customers and (@customers.size == 1)
      redirect_to customer_url(@customers.first)
    else
      @customer_names = M2m::Customer.all_names
    end
  end

  def show
    @customer = current_object
    @total_sales_orders = @customer.sales_orders.count
    @sales_orders = @customer.sales_orders.by_order_number_desc.includes(:releases).limit(5)
    M2m::SalesOrderRelease.attach_to_sales_orders(@sales_orders)
    M2m::SalesOrderItem.attach_to_releases(@sales_orders.map(&:releases).flatten)
    @total_quotes = @customer.quotes.count
    @quotes = @customer.quotes.by_quote_number_desc.all(:include => :items, :limit => 1)
    # @previous_customer = M2m::Customer.find(:first, :conditions => ['fcompany < ?', current_object.fcompany], :order => 'fcompany desc')
    # @next_customer = M2m::Customer.find(:first, :conditions => ['fcompany > ?', current_object.fcompany], :order => 'fcompany')
  end

  protected

    def model_class
      M2m::Customer
    end
    
    def current_object
      @current_object ||= if params[:custno] == 'true'
        M2m::Customer.where(:fcustno => M2m::Customer.fcustno_for(params[:id])).first
      else
        M2m::Customer.find(params[:id])
      end
    end
end
