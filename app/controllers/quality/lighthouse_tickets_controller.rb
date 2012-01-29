class Quality::LighthouseTicketsController < ApplicationController
  def create
    @rma = parent_object
    @lighthouse_ticket = Lighthouse::Ticket.from_rma(@rma, current_user)
    if ticket_params = params[:lighthouse_ticket]
      @lighthouse_ticket.title = ticket_params['title']
      @lighthouse_ticket.body = ticket_params['body']
      @lighthouse_ticket.assigned_user_id = ticket_params['assigned_user_id']
    end
    if @lighthouse_ticket.save
      @rma.set_lighthouse_ticket_id(@lighthouse_ticket.id)
      @rma.save
      redirect_to rma_url(@rma.rma_number)
    else
      @lighthouse_users = Lighthouse::Ticket.user_options(CompanyConfig.lighthouse_rma_project_id)
      render :action => 'quality/rmas/show'
    end
  end

  protected
  
    # Just for auth logic.
    def model_class
      LighthouseTicket
    end

    def parent_object
      @parent_object ||= M2m::Rma.find(params[:rma_id])
    end

end