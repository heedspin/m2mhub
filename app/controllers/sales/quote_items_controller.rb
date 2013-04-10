class Sales::QuoteItemsController < M2mhubController
  filter_access_to_defaults

  def create
    @quote = parent_object
    @quote_item = build_object
    respond_to do |format|
      format.js {
        if @quote_item.save
          render :action => 'create'
        else
          render :action => 'error'
        end
      }
    end
  end

  def show
    @quote = parent_object
    @quote_item = current_object
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def edit
    @quote = parent_object
    @quote_item = current_object
  end
  
  def update
    @quote = parent_object
    @quote_item = current_object
    respond_to do |format|
      format.js {
        if @quote_item.update_attributes(params[model_name])
          render :action => 'show'
        else
          render :action => 'error'
        end
      }
    end
  end    

  def destroy
    @quote = parent_object
    @quote_item = current_object
    @quote_item.destroy
    respond_to do |format|
      format.js {
        render :json => { :result => 'success' }.to_json
      }
    end
  end

  protected

    def model_name
      :quote_item
    end

    def model_class
      Sales::QuoteItem
    end

    def parent_object
      @parent_object ||= Sales::Quote.find(params[:sales_quote_id])
    end
    
    def build_object
      self.parent_object.items.build(params[model_name])
    end

end
