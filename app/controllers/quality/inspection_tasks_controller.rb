class Quality::InspectionTasksController < M2mhubController
  filter_access_to_defaults

  def index
    if poi = params[:poi]
      unless task = Quality::InspectionTask.find_by_purchase_order_item_id(poi)
        poi = M2m::PurchaseOrderItem.find(poi)
        task = Quality::InspectionTask.friendly_purchase_order_number(poi.purchase_order_number).part_number(poi.part_number).first
      end
      redirect_to inspection_task_url(task)
    else
      @search = Quality::InspectionTask.new(params.fetch(:search, nil).try(:permit!))
      unless params.member?(:search)
        @search.status = Quality::InspectionTaskStatus.all_open
      end
      s = Quality::InspectionTask
      if @search.status
        s = s.status(@search.status)
      end
      if @search.task_type
        s = s.task_type(@search.task_type)
      end

      @tasks = s.paginate(:page => params[:page], :per_page => 50)
      if M2mhub::Feature.enabled?(:inspection_queue)
        @inspection_items = Production::InspectionItem.all.sort_by { |ip| ip.last_inbound_transaction.time }.reverse
      end
    end
  end

  def new
    @task = build_object
    if poi = @task.purchase_order_item
      @task.initialize_from_purchase_order_item(poi)
    end
  end

  def edit
    @task = current_object
  end

  def create
    @task = build_object
    if @task.save
      redirect_to inspection_task_url(@task)
    else
      render :action => 'new'
    end
  end

  def update
    @task = current_object
    if @task.update_attributes(params.require(model_name).permit!)
      redirect_to inspection_task_url(@task)
    else
      render :action => 'edit'
    end
  end

  def show
    @task = current_object
    @task.update_lighthouse_status!
  end
  
  def destroy
    @task = current_object
    if task_params = params.require(model_name).permit!
      # @task.delete_lighthouse_ticket = value_to_bool(task_params[:delete_lighthouse_ticket])
    end
    @task.destroy
    respond_to do |format|
      destination = inspection_tasks_url
      format.html {
        flash[:notice] = "Task Deleted"
        redirect_to destination
      }
      format.js {
        render :json => { :location => destination }.to_json
      }
    end
  end

  protected
  
    def model_name
      :quality_inspection_task
    end
  
    def model_class
      Quality::InspectionTask
    end

    def build_object
      @current_object ||= super
      @current_object.status ||= Quality::InspectionTaskStatus.awaiting_receipt
      @current_object.task_type ||= Quality::InspectionTaskType.incoming_inspection
      @current_object.lighthouse_project_id ||= AppConfig.inspection_task_default_lighthouse_project
      @current_object.lighthouse_assigned_user_id ||= AppConfig.inspection_task_default_lighthouse_user
      @current_object.lighthouse_milestone_id ||= AppConfig.inspection_task_default_lighthouse_incoming_milestone
      @current_object
    end
end
