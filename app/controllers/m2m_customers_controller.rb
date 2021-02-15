require 'amatcher'
class M2mCustomersController < M2mhubController
  filter_access_to_defaults

  def index
    if (@search_term = params[:term]).present?
      autocomplete_index
    else
      search_index
    end
  end

  def new
    if data = params[:d]
      params[:m2m_customer] ||= {}
      M2m::Customer.data_to_params(data, params[:m2m_customer])
    end
    @customer = M2m::Customer.new(params[:m2m_customer])
    similar_customers = Amatcher.find_similar( :match => @customer.company_name, :method => :company_name,
                                               :objects => M2m::Customer.select('slcdpmx.identity_column, slcdpmx.fcompany'),
                                               :limit => 10, :threshold => 0.7 )
    if similar_customers.size > 0
      @similar_customers = similar_customers.map(&:object)
    end
  end

  def edit
    @customer = current_object
    @customer.strip_strings
  end

  def create
    @customer = M2m::Customer.new(params[:m2m_customer])
    if @customer.save
      # @customer.after_save_madness!
      redirect_to m2m_customer_contacts_url(@customer)
    else
      render :action => 'new'
    end
  end

  def update
    @customer = current_object
    if @customer.update_attributes(params.require(:m2m_customer).permit!)
      redirect_to m2m_customer_contacts_url(@customer)
    else
      render :action => 'edit'
    end
  end

  def autocomplete_index
    # Autocomplete path.
    @customers = M2m::Customer.name_like(@search_term).by_name.select('slcdpmx.fcompany').limit(20)
    names = @customers.map { |c| { :label => c.name, :value => c.name } } 
    if params[:new_prompt] == '1'
      names.push( { :label => "Create New: #{@search_term}", :value => "Create New: #{@search_term}" })
    elsif @customers.size == 0
      names.push( { :label => 'No Results', :value => 'No Results' })
    end
    render :json => names.to_json
  end

  def search_index
    @search = M2m::Customer.new(params.fetch(:search, nil).try(:permit!))
    # For who knows what reason, a new customer comes out with a name = " ".
    if @search.fcompany
      @search.fcompany = @search.fcompany.strip
    end
    if @search.fcompany.present?
      @customers = M2m::Customer.name_like(@search.fcompany.strip).paginate(:page => params[:page], :per_page => 50).order(:fcompany)
    end
    if @customers and (@customers.size == 1)
      redirect_to m2m_customer_url(@customers.first)
    end
  end

  def show
    @customer = current_object
    @total_sales_orders = @customer.sales_orders.count
    @sales_orders = @customer.sales_orders.by_order_number_desc.includes(:releases).limit(5)
    M2m::SalesOrderRelease.attach_to_sales_orders(@sales_orders)
    M2m::SalesOrderItem.attach_to_releases(@sales_orders.map(&:releases).flatten)
    @total_quotes = @customer.quotes.count
    @quotes = @customer.quotes.by_quote_number_desc.includes(:items).limit(1)
    # @previous_customer = M2m::Customer.find(:first, :conditions => ['fcompany < ?', current_object.fcompany], :order => 'fcompany desc')
    # @next_customer = M2m::Customer.find(:first, :conditions => ['fcompany > ?', current_object.fcompany], :order => 'fcompany')
  end

  protected

    def model_class
      M2m::Customer
    end

    def current_object
      @current_object ||= if params[:custno] == 'true'
        M2m::Customer.with_customer_number(params[:id]).first || (raise ActiveRecord::RecordNotFound)
      else
        M2m::Customer.find(params[:id])
      end
    end
end
