class Shipping::ShippersController < M2mhubController
  filter_access_to_defaults

  def index
    if date = params[:date]
      @date = Date.parse(date)
    end
    @date ||= Date.current
    @shippers = M2m::Shipper.with_ship_date(@date).by_shipper_number_desc.includes(:items)
    M2m::ShipperItem.attach_sales_orders(@shippers)
    M2m::Item.attach_items(@shippers.map(&:items).flatten)
    if next_shipper = M2m::Shipper.for_next_day(@date).first
      @next_date = next_shipper.ship_date
    elsif @date < Date.current
      @next_date = Date.current
    end
    if previous_shipper = M2m::Shipper.for_previous_day(@date).first
      @previous_date = previous_shipper.ship_date
    end
  end

  def show
    @shipper = current_object
  end

  protected

    def model_class
      M2m::Shipper
    end
end
