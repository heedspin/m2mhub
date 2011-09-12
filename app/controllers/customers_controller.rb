class CustomersController < ApplicationController
  filter_access_to_defaults

  def index
    @customers = M2m::Customer.paginate(:all, :page => params[:page], :per_page => 50, :order => 'fcompany')
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
