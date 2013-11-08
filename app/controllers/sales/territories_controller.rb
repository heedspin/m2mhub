class Sales::TerritoriesController < M2mhubController
  filter_access_to_defaults

  helper_method :sales_rep_options
  def sales_rep_options
    M2m::Vendor.where(:fcacctnum => AppConfig.sales_rep_gl_account_number.to_s).all.sort_by(&:name)
  end

  def index
    @territories = Sales::Territory.by_name.all
  end

  def new
    @territory = build_object
  end

  def edit
    @territory = current_object
  end

  def create
    @territory = build_object
    if @territory.save
      redirect_to sales_territories_url
    else
      render :action => 'new'
    end
  end

  def update
    @territory = current_object
    if @territory.update_attributes(params[:sales_territory])
      redirect_to sales_territories_url
    else
      render :action => 'edit'
    end
  end

  def show
    @territory = current_object
  end
  
  def destroy
    @territory = current_object
    @territory.destroy
    redirect_to sales_territories_url
  end

  protected
  
    def model_name
      :sales_territory
    end

    def model_class
      Sales::Territory
    end
end
