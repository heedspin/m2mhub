class M2mhub::TriggersController < M2mhubController
  filter_access_to_defaults

  def index
    @triggers = M2mhub::Trigger.not_deleted.by_part_number.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @trigger = build_object
  end

  def edit
    @trigger = current_object
  end

  def create
    @trigger = build_object
    if @trigger.save
      redirect_to m2mhub_triggers_url
    else
      render :action => 'new'
    end
  end

  def update
    @trigger = current_object
    if @trigger.update_attributes(params[:m2mhub_trigger])
      redirect_to m2mhub_triggers_url
    else
      render :action => 'edit'
    end
  end

  def show
    @trigger = current_object
    @events = @trigger.events.latest_first.paginate(:page => params[:page], :per_page => 10)
  end
  
  def destroy
    @trigger = current_object
    flash[:notice] = "Trigger Deleted"
    @trigger.destroy
    redirect_to m2mhub_triggers_url
  end

  protected
  
    def model_name
      :m2mhub_trigger
    end

    def model_class
      M2mhub::Trigger
    end

    def build_object
      @current_object ||= super
      @current_object.notification_type ||= M2mhub::NotificationType.ticket
      @current_object.trigger_state ||= M2mhub::TriggerState.enabled
      @current_object.target_user ||= current_user
      @current_object
    end
end
