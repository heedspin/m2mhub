require 'amatcher'
class Sales::OpportunitiesController < M2mhubController
  filter_access_to_defaults

  class Search < Sales::Opportunity
    attr_accessor :sales_territory_id
  end

  def index
    @search = Search.new(params[:search])
    unless params.member?(:search)
      @search.status = Sales::OpportunityStatus.active
    end
    s = Sales::Opportunity
    if @search.status_id
      s = s.status(@search.status_id)
    else
      s = s.not_deleted
    end
    s = s.customer_name_like(@search.customer_name) if @search.customer_name.present?
    s = s.sales_territory(@search.sales_territory_id) if @search.sales_territory_id.present?
    s = s.owner(@search.owner_id) if @search.owner_id
    @opportunities = s.by_last_update_desc.paginate(:page => params[:page], :per_page => 50)
    respond_to do |format|
      format.html
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"LXD_Opportunities.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => Sales::Opportunity::Export.new(@opportunities).to_xls
      end
    end
  end

  def new
    @opportunity = build_object
    if @opportunity.sales_customer
      @opportunity.customer_name = @opportunity.sales_customer.name
    else
      @opportunity.build_sales_customer
    end
  end

  def edit
    @opportunity = current_object
  end

  def create
    @opportunity = build_object
    @opportunity.status = Sales::OpportunityStatus.active
    if params[:sales_opportunity][:create_customer] and @opportunity.sales_customer
      @opportunity.sales_customer.name = @opportunity.customer_name
    end
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
    if @opportunity.sales_customer.nil?
      @similar_customers = if @opportunity.customer_name.present?
        Amatcher.find_similar( :match => @opportunity.customer_name, :method => :name,
                               :objects => Sales::Customer.scoped(:select => 'id, name'),
                               :limit => 10, :threshold => 0.7 )
      else
        []
      end
    end
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
