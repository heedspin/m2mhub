class QuotesController < M2mhubController
  filter_access_to_defaults

  def index
    @quotes = M2m::Quote.status_open.order('fquotedate desc, fquoteno desc').paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @quote = current_object
    @previous_quote = M2m::Quote.find(:first, :conditions => ['fquoteno < ?', current_object.fquoteno], :order => 'fquoteno desc')
    @next_quote = M2m::Quote.find(:first, :conditions => ['fquoteno > ?', current_object.fquoteno], :order => 'fquoteno')
  end
  
  def new
    @quote = M2m::Quote.new
    @quote_item = @quote.items.new
  end

  protected

    def model_class
      M2m::Quote
    end
    
    # def current_object
    #   @current_object ||= M2m::Quote.includes(:items).find(params[:id])
    # end
end
