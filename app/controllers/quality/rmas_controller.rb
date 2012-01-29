class Quality::RmasController < ApplicationController
  def show
    @rma = current_object
    unless @lighthouse_ticket = @rma.lighthouse_ticket
      @lighthouse_ticket = Lighthouse::Ticket.from_rma(@rma, current_user)
    end
  end

  protected
  
    def model_class
      M2m::Rma
    end

end