class Sales::OpportunitiesController < M2mhubController
  filter_access_to_defaults

  def index
    @search = Sales::Opportunity.new(params[:search])
    unless params.member?(:search)
      @search.status = Sales::OpportunityStatus.active
    end
    s = Sales::Opportunity
    if @search.status_id
      s = s.status(@search.status_id)
    else
      s = s.not_deleted
    end
    if @search.customer_name.present?
      s = s.customer_name_like(@search.customer_name)
    end
    @opportunities = s.by_customer_name.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @opportunity = build_object
  end

  def edit
    @opportunity = current_object
  end

  def create
    @opportunity = build_object
    @opportunity.status = Sales::OpportunityStatus.active
    if @opportunity.save
      flash[:notice] = "Created Opportunity #{@opportunity.id}"
      if params[:commit] == 'Create & New'
        redirect_to new_opportunity_url
      else
        redirect_to opportunity_url(@opportunity)
      end
    else
      render :action => 'new'
    end
  end

  def update
    @opportunity = current_object
    if @opportunity.update_attributes(params[model_name])
      redirect_to opportunity_url(@opportunity)
    else
      render :action => 'edit'
    end
  end

  def show
    @opportunity = current_object
    @comment = @opportunity.build_ticket_comment(current_user.full_name,
                                                 current_user.lighthouse_user_id)
    @comments = @opportunity.comments.by_id
  end

  def destroy
    @opportunity = current_object
    if opportunity_params = params[model_name]
      @opportunity.delete_permanently = value_to_bool(opportunity_params[:delete_permanently])
    end
    @opportunity.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "Opportunity Deleted"
        redirect_to opportunities_url
      }
      format.js {
        render :json => { :location => opportunities_url }.to_json
      }
    end
  end

  protected

    def model_name
      :sales_opportunity
    end

    def model_class
      Sales::Opportunity
    end

    def current_object
      @current_object ||= Sales::Opportunity.find(params[:id])
    end
end
