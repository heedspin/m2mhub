class Context::CommentsController < M2mhubController
  filter_access_to_defaults

  def index
    @comments = Context::Comment.not_deleted.last_first.accessible_to(current_user)
    respond_to do |format|
      format.json {
        render :json => @comments
      }
    end
  end

  def create
    @comment = build_object
    respond_to do |format|
      format.json {
        if @comment.save
          render :json => @comment
        else
          logger.error 'Failed to save comment: ' + @comment.errors.full_messages.join("\n")
          render :json => @comment.errors, :status => :unprocessable_entity
        end
      }
    end
  end

  # def show
  #   @quote = parent_object
  #   @quote_item = current_object
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end
  # 
  # def edit
  #   @quote = parent_object
  #   @quote_item = current_object
  # end
  # 
  def update
    @comment = current_object
    logger.info("UPDATE")
    respond_to do |format|
      format.json {
        if @comment.update_attributes(params.require(model_name).permit!)
          render :json => { :result => 'success' }
        else
          render :json => @comment.errors, :status => :unprocessable_entity
        end
      }
    end
  end    

  def destroy
    @comment = current_object
    respond_to do |format|
      format.json {
        if @comment.destroy
          render :json => { :result => 'success' }
        else
          render :json => @comment.errors, :status => :unprocessable_entity
        end
      }
    end
  end

  protected

    def model_name
      :comment
    end

    def model_class
      Context::Comment
    end
    
    def current_object
      if @current_object.nil?
        if @current_object = super
          unless @current_object.context.try(:accessible_to?, current_user)
            @current_object = nil
          end
        end
      end
      @current_object
    end

end
