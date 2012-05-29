class Shipping::ShippingDashboardController < ::M2mhubController
  filter_access_to_defaults
  
  def index
    if date = params[:date]
      @date = Date.parse(date)
    end
    @date ||= Date.current
    @receivers = M2m::Receiver.by_id_desc.limit(10).includes(:items)
    @shippers = M2m::Shipper.by_shipper_number_desc.limit(10).includes(:items)
  end
end