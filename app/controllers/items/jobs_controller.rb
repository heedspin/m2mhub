class Items::JobsController < ApplicationController
  filter_access_to_defaults

  def index
    @popup_layout = params[:layout] == 'popup'
    @item = parent_object
    @jobs = M2m::Job.for_item(@item).by_date_desc
    @jobs = @jobs.paginate(:page => params[:page], :per_page => 5)
    if @popup_layout
      render :action => 'popup', :layout => 'popup'
    end
  end

  protected

    def model_class
      M2m::Job
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
