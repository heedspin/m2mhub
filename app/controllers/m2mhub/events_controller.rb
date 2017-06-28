class M2mhub::EventsController < M2mhubController
  filter_access_to_defaults

  def index
    @events = M2mhub::Event.latest_first.paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @event = build_object
  end

  def edit
    @event = current_object
  end

  def create
    @event = build_object
    if @event.save
      redirect_to m2mhub_events_url
    else
      render :action => 'new'
    end
  end

  def update
    @event = current_object
    if @event.update_attributes(params.require(:m2mhub_event).permit!)
      redirect_to m2mhub_events_url
    else
      render :action => 'edit'
    end
  end

  def show
    @event = current_object
  end
  
  def destroy
    @event = current_object
    flash[:notice] = "Event Deleted"
    @event.destroy
    redirect_to m2mhub_events_url
  end

  protected
  
    def model_name
      :m2mhub_event
    end

    def model_class
      M2mhub::Event
    end

    def build_object
      @current_object ||= super
      @current_object.notification_type ||= M2mhub::NotificationType.lighthouse_ticket
      @current_object.event_state ||= M2mhub::eventState.enabled
      @current_object.target_user ||= current_user
      @current_object
    end
end
