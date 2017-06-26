class Shipping::DailyReportsController < M2mhubController
  filter_access_to_defaults

  def index
    if date = params[:date]
      @date = DateParser.parse(date)
    end
    @date ||= Date.current

    @shippers = M2m::Shipper.with_ship_date(@date).by_shipper_number_desc.includes(:items)
    M2m::ShipperItem.attach_sales_orders(@shippers)
    M2m::Item.attach_items(@shippers.map(&:items).flatten)
    if next_shipper = M2m::Shipper.for_next_day(@date).first
      @next_date = next_shipper.ship_date.to_date
    elsif @date < Date.current
      @next_date = Date.current
    end
    if previous_shipper = M2m::Shipper.for_previous_day(@date).first
      @previous_date = previous_shipper.ship_date.to_date
    end

    @receivers = M2m::Receiver.with_date_received(@date).by_id_desc.includes(:items)
    M2m::Item.attach_items(@receivers.map(&:items).flatten)
    # M2m::ReceiverItem.attach_sales_orders(@shippers)
    if (next_receiver_date = M2m::Receiver.for_next_day(@date).first.try(:date_received).try(:to_date)) and (next_receiver_date < @next_date)
      @next_date = next_receiver_date
    end
    if (previous_receiver_date = M2m::Receiver.for_previous_day(@date).first.try(:date_received).try(:to_date)) and (previous_receiver_date > @previous_date.to_date)
      @previous_date = previous_receiver_date
    end
  end

  protected

    def model_class
      M2m::Shipper
    end
end
