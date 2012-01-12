class Shipping::ShippingDashboardController < ::ApplicationController
  filter_access_to_defaults
  
  def index
    if date = params[:date]
      @date = Date.parse(date)
    end
    @date ||= Date.current
    @receivers = M2m::Receiver.with_date_received(@date).by_id_desc.all(:include => :receiver_items)
    @shippers = M2m::Shipper.with_ship_date(@date).by_shipper_number_desc.all(:include => :items)
  end
end