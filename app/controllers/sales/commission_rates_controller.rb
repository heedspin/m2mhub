class Sales::CommissionRatesController < M2mhubController
  filter_access_to_defaults

  def index
    if AppConfig.use_item_revisions?
      raise "Need to implement item autocomplete with revisions"
    end

    @search = Sales::CommissionRate.new(params.fetch(:search, nil).try(:permit!))
    s = Sales::CommissionRate
    if @search.sales_person_id.present?
      s = s.sales_person(@search.sales_person_id)
    end
    if @search.customer_id.present?
      s = s.customer(@search.customer_id)
    end
    if @search.item_id.present?
      s = s.item(@search.item_id)
    end

    @commission_rates = s.by_salesperson_and_customer.paginate(:page => params[:page], :per_page => 50)
    sales_person_ids = Sales::CommissionRate.connection.select_values('select distinct sales_person_id from commission_rates')
    @sales_person_options = M2m::SalesPerson.where(['identity_column in (?)', sales_person_ids]).by_name.all
    customer_ids = Sales::CommissionRate.connection.select_values('select distinct customer_id from commission_rates')
    @customer_options = M2m::Customer.where(['identity_column in (?)', customer_ids]).by_name.all
    item_ids = Sales::CommissionRate.connection.select_values('select distinct item_id from commission_rates')
    @item_options = M2m::Item.where(['identity_column in (?)', item_ids]).by_part_rev_desc.all
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
      flash[:notice] = "Created Commission Rate #{@commission_rate.id}"
      if params[:commit] == 'Create & New'
        redirect_to new_commission_rate_url
      else
        redirect_to commission_rates_url
      end
    else
      render :action => 'new'
    end
  end

  def update
    @commission_rate = current_object
    if @commission_rate.update_attributes(params.require(:sales_commission_rate).permit!)
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
