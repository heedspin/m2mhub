class Quality::RmasController < M2mhubController
  def show
    @rma = M2m::Rma.find params[:id]
  end
end
