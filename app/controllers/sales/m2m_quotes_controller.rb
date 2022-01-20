class Sales::M2mQuotesController < M2mhubController
  filter_access_to_defaults :context => :m2m_quotes

  def index
    @quotes = M2m::Quote.status_open.order('fquotedate desc, fquoteno desc').paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @quote = M2m::Quote.with_quote_number(params[:id]).first
    @previous_quote = M2m::Quote.where(['qtmast.fquoteno < ?', @quote.fquoteno.to_i]).order('qtmast.fquoteno desc').first
    @next_quote = M2m::Quote.where(['qtmast.fquoteno > ?', @quote.fquoteno.to_i]).order('qtmast.fquoteno').first
  end
  
  def new
    @quote = M2m::Quote.new
    @quote_item = @quote.items.new
  end

  protected

  def current_object
    @quote
  end

end
