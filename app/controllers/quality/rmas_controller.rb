class Quality::RmasController < ApplicationController
  def show
    @rma = current_object
  end

  protected
  
    def model_class
      M2m::Rma
    end

end