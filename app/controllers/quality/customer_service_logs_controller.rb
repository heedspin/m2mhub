class Quality::CustomerServiceLogsController < ApplicationController
  def show
    @csl = current_object
  end

  protected
  
    def model_class
      M2m::CustomerServiceLog
    end

end