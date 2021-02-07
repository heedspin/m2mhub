class Quality::RmasController < M2mhubController
  def show
    @rma = current_object
    if AppConfig.lighthouse_account
      rma_item = @rma.items.order(:fcrmano).first
      title = Date.current.strftime("%y%m%d") + "-#{@rma.rma_number} -- " + @rma.customer_name.strip + ': ' + rma_item.try(:part_number)
      title[0] = 'R'
      body = rma_item.try(:reason)
    end
  end

  protected

    def model_class
      M2m::Rma
    end

end
