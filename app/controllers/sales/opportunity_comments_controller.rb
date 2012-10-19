class Sales::OpportunityCommentsController < M2mhubController
  filter_access_to_defaults

  def edit
    @comment = current_object
    @opportunity = @comment.opportunity
  end

  def create
    @comment = build_object
    @opportunity = @comment.opportunity
    @comment.creator_id = current_user.id
    if @comment.save
      if @comment.status_change?
        @opportunity.update_attributes(:status_id => @comment.status_id)
      end
      flash[:notice] = "Created Comment #{@comment.id}"
      redirect_to opportunity_url(@opportunity)
    else
      render :action => 'sales/opportunities/new'
    end
  end

  def update
    @comment = current_object
    @opportunity = @comment.opportunity
    if @comment.update_attributes(params[model_name])
      redirect_to opportunity_url(@opportunity)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @comment = current_object
    if comment_params = params[model_name]
      @comment.delete_lighthouse_ticket = value_to_bool(comment_params[:delete_lighthouse_ticket])
    end
    flash[:notice] = "Comment Deleted"
    @comment.destroy
    respond_to do |format|
      destination = opportunity_url(@comment.opportunity)
      format.html {
        flash[:notice] = "Opportunity Deleted"
        redirect_to destination
      }
      format.js {
        render :json => { :location => destination }.to_json
      }
    end
  end

  protected
  
    def model_name
      :sales_opportunity_comment
    end
  
    def model_class
      Sales::OpportunityComment
    end

    def current_object
      @current_object ||= Sales::OpportunityComment.find(params[:id])
    end
end
