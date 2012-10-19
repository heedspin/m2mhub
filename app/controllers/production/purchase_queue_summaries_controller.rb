class Production::PurchaseQueueSummariesController < M2mhubController
  filter_access_to_defaults
  
  def index
    @summaries = M2m::PurchaseQueueSummary.by_due_date.paginate(:page => params[:page], :per_page => 50)
  end
  
  def show
    @summary = current_object
    @details = @summary.details
  end
  
  protected
  
    def model_class
      M2m::PurchaseQueueSummary
    end
    
end

