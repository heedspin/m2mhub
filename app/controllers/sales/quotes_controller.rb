class Sales::QuotesController < M2mhubController
  filter_access_to_defaults

  def index
    @quotes = Sales::Quote.by_created_at_desc.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @quote = build_object
  end

  def edit
    @quote = current_object
  end

  def create
    @quote = build_object
    if @quote.save
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
    if params[:print]
      render :action => 'print', :layout => false
    end
  end

  def destroy
    @quote = current_object
    @quote.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "Quote #{@quote.quote_number} Deleted"
        redirect_back_or_default sales_quotes_url
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
        @current_object.current_user = current_user
      end
      @current_object
    end
    
    def build_object
      if @current_object.nil?
        @current_object = Sales::Quote.new(params[model_name])
        if @current_object.customer_name.blank?
          @current_object.customer_name = @current_object.customer.try(:name)
        end
        @current_object.current_user = current_user
      end
      @current_object
    end
end
