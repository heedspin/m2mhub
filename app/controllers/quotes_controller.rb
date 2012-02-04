class QuotesController < ApplicationController
  filter_access_to_defaults

  def index
    # @quotes = M2m::Quote.status_open.order('fquotedate desc, fquoteno desc').limit(per_page).offset(page).paginate(:page => params[:page], :per_page => 50)

    page = (params[:page] || 1).to_i
    per_page = 50
    pagenum = ::WillPaginate::PageNumber(page.nil? ? 1 : page)
    @quotes = WillPaginate::Collection.create(page, per_page) do |pager|
      quote_scope = M2m::Quote.status_open
      pager.replace quote_scope.order('fquotedate desc, fquoteno desc').scoped(:limit => per_page, :offset => pagenum.to_offset(per_page).to_i)
  
      unless pager.total_entries
        # the pager didn't manage to guess the total count, do it manually
        pager.total_entries = quote_scope.count
      end
    end
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
end
