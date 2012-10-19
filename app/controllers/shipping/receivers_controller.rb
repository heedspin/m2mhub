class Shipping::ReceiversController < M2mhubController
  filter_access_to_defaults

  def index
    if date = params[:date]
      @date = Date.parse(date)
    end
    @date ||= Date.current
    @receivers = M2m::Receiver.with_date_received(@date).by_id_desc.includes(:items)
    M2m::Item.attach_items(@receivers.map(&:items).flatten)
    # M2m::ReceiverItem.attach_sales_orders(@shippers)
    if next_receiver = M2m::Receiver.for_next_day(@date).first
      @next_date = next_receiver.date_received
    elsif @date < Date.current
      @next_date = Date.current
    end
    if previous_receiver = M2m::Receiver.for_previous_day(@date).first
      @previous_date = previous_receiver.date_received
    end
  end

  def show
    @receiver = current_object
  end

  protected

    def model_class
      M2m::Receiver
    end
end
