require 'amatcher'
class Sales::OpportunitiesController < M2mhubController
  filter_access_to_defaults

  class Search < Sales::Opportunity
    attr_accessor :sales_territory_id
    attr_accessor :win_type_search_id
  end

  def index
    @search = Search.new(params[:search])
    unless params.member?(:search)
      @search.status = Sales::OpportunityStatus.open_and_hold
      # Introduces 1 opp trap: @search.owner_id = current_user.id
    end
    s = Sales::Opportunity
    @search.xnumber = @search.xnumber.strip.upcase if @search.xnumber.present?
    if @search.xnumber.present? and (s = s.xnumber(@search.xnumber)) and (s.count == 1)
      # Going direct to xnumber opportunity.
      @opportunities = s
    else
      if @search.status_id
        s = s.status(@search.status_id)
      else
        s = s.not_deleted
      end
      s = s.customer_name_like(@search.customer_name) if @search.customer_name.present?
      s = s.sales_territory(@search.sales_territory_id) if @search.sales_territory_id.present?
      s = s.owner(@search.owner_id) if @search.owner_id
      s = s.win_type_search(@search.win_type_search_id) if @search.win_type_search_id.present?
      @opportunities = s.by_amount_desc.paginate(:page => params[:page], :per_page => 20)
    end
    respond_to do |format|
      format.html do 
        if s.size == 1
          redirect_to opportunity_url(@opportunities.first.xnumber)
        end
      end
      format.xls do
        headers['Content-Disposition'] = "attachment; filename=\"LXD_Opportunities.xls\""
        headers['Content-type'] = 'application/vnd.ms-excel'
        render :text => Sales::Opportunity::Export.new(@opportunities).to_xls
      end
    end
  end

  def new
    @opportunity = build_object
    @opportunity.owner_id = current_user.id
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
    if @opportunity.create_customer and @opportunity.sales_customer
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
      if @current_object.nil?
        id = params[:id]
        if id[0..0] == 'X'
          @current_object = Sales::Opportunity.xnumber(id).first || record_not_found
        else
          @current_object = Sales::Opportunity.find(id)
        end
      end
      @current_object
    end
end
