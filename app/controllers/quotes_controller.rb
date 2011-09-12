require "page_utils"

class QuotesController < ApplicationController
  include PageUtils
  filter_access_to_defaults

  def index
    @quotes = M2m::Quote.open.paginate(:all, :page => params[:page], :per_page => 50, :order => 'fquotedate desc, fquoteno desc')
  end

  def show
    @quote = current_object
    if previous_quote = M2m::Quote.find(:first, :conditions => ['fquoteno < ?', current_object.fquoteno], :order => 'fquoteno desc')
      set_previous_page previous_quote.fquoteno, quote_url(previous_quote.fquoteno), previous_quote
    end
    if next_quote = M2m::Quote.find(:first, :conditions => ['fquoteno > ?', current_object.fquoteno], :order => 'fquoteno')
      set_next_page next_quote.fquoteno, quote_url(next_quote.fquoteno), next_quote
    end
  end

  protected

    def model_class
      M2m::Quote
    end
end
