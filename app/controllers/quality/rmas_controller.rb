class Quality::RmasController < M2mhubController
  def show
    @rma = M2m::Rma.with_rma_number(params[:id]).first
  end
end
