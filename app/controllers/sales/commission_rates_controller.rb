class Sales::CommissionRatesController < M2mhubController
  filter_access_to_defaults

  def index
    if AppConfig.use_item_revisions?
      raise "Need to implement item autocomplete with revisions"
    end
    @commission_rates = Sales::CommissionRate.by_salesperson_and_customer.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @commission_rate = build_object
  end

  def edit
    @commission_rate = current_object
  end

  def create
    @commission_rate = build_object
    if @commission_rate.save
      redirect_to commission_rates_url
    else
      render :action => 'new'
    end
  end

  def update
    @commission_rate = current_object
    if @commission_rate.update_attributes(params[:sales_commission_rate])
      redirect_to commission_rates_url
    else
      render :action => 'edit'
    end
  end

  def show
    @commission_rate = current_object
  end
  
  def destroy
    @commission_rate = current_object
    flash[:notice] = "Commission Rate Deleted"
    @commission_rate.destroy
    redirect_to commission_rates_url
  end

  protected
  
    def model_name
      :sales_commission_rate
    end

    def model_class
      Sales::CommissionRate
    end

    def current_object
      @current_object ||= Sales::CommissionRate.find(params[:id])
    end
end
