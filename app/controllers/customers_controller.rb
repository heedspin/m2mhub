class CustomersController < ApplicationController
  filter_access_to_defaults

  def index
    @search = M2m::Customer.new(params[:search])
    # For who knows what reason, a new customer comes out with a name = " ".
    if @search.fcompany
      @search.fcompany = @search.fcompany.strip
    end
    if @search.fcompany.present?
      @customers = M2m::Customer.name_like(@search.fcompany.strip).paginate(:all, :page => params[:page], :per_page => 50, :order => 'fcompany')
    end
    if @customers and (@customers.size == 1)
      redirect_to customer_url(@customers.first.fcustno)
    else
      @customer_names = M2m::Customer.all_names
    end
  end

  def show
    @customer = current_object
    @previous_customer = M2m::Customer.find(:first, :conditions => ['fcompany < ?', current_object.fcompany], :order => 'fcompany desc')
    @next_customer = M2m::Customer.find(:first, :conditions => ['fcompany > ?', current_object.fcompany], :order => 'fcompany')
  end

  protected

    def model_class
      M2m::Customer
    end
end
