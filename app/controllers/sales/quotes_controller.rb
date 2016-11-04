class Sales::QuotesController < M2mhubController
  filter_access_to_defaults

  def index
    @quotes = Sales::Quote.by_created_at_desc.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @quote = build_object
    if @quote.link_opportunity_id
      opportunity = Sales::Opportunity.find(@quote.link_opportunity_id)
      @quote.sales_customer = opportunity.sales_customer
      @quote.customer_name = opportunity.customer_name
    end
    if last_quote = Sales::Quote.by_created_at_desc.creator(current_user).first
      @quote.foreword = last_quote.foreword
      @quote.postfix = last_quote.postfix
    end
  end

  def edit
    @quote = current_object
  end

  def create
    @quote = build_object
    success = false
    Sales::Quote.transaction do
      if @quote.save
        if @quote.link_opportunity_id
          opportunity = Sales::Opportunity.find(@quote.link_opportunity_id)
          comment = opportunity.comments.build
          comment.creator_id = current_user.id
          comment.quote_id = @quote.id
          comment.comment_type = Sales::OpportunityCommentType.quote
          comment.status = Sales::OpportunityStatus.active
          unless success = comment.save
            logger.error 'Failed to create opportunity comment: ' + comment.errors.full_messages.join("\n")
          end
        else
          success = true
        end
      end
    end
    if success
      flash[:notice] = "Created Quote #{@quote.id}"
      redirect_to sales_quote_url(@quote)
    else
      render :action => 'new'
    end
  end

  def update
    @quote = current_object
    if @quote.update_attributes(params[model_name])
      redirect_back_or_default sales_quote_url(@quote)
    else
      render :action => 'edit'
    end
  end

  def show
    @quote = current_object
    @quote.date = Date.current
    if params[:print]
      render :action => 'print', :layout => false
    end
  end

  def destroy
    @quote = current_object
    @quote.destroy
    respond_to do |format|
      flash[:notice] = "Quote #{@quote.quote_number} Deleted"
      format.js {
        render :json => { :location => sales_quotes_url }.to_json
      }
      format.html {
        redirect_to sales_quotes_url
      }
    end
  end

  protected

    def model_name
      :sales_quote
    end

    def model_class
      Sales::Quote
    end

    def current_object
      if @current_object.nil?
        @current_object = Sales::Quote.find(params[:id])
      end
      @current_object
    end
    
    def build_object
      if @current_object.nil?
        @current_object = Sales::Quote.new(params[model_name])
        if @current_object.customer_name.blank?
          @current_object.customer_name = @current_object.sales_customer.try(:name)
        end
      end
      @current_object
    end
end
