class Production::PurchaseQueueNotesController < M2mhubController
  filter_access_to_defaults

  def new
    @note = build_object
  end

  def create
    @note = build_object
    respond_to do |format|
      format.html {
        if @note.save
          redirect_to purchase_queue_note_url(@note)
        else
          render :action => 'new'
        end        
      }
      format.js {
        render :action => 'show'
      }
    end
  end

  def show
    @note = current_object
    @customer_reports = @note.customer_reports.by_on_hand_desc.paginate(:page => params[:page], :per_page => 1)
    respond_to do |format|
      format.html
      format.json {
        result = if @note.delayed_job_status.in_progress?
          { :inprogress => true }
        else
          { :inprogress => false,
            :html => render_to_string(:partial => 'show.html.erb',
                                      :layout => false) }
        end
        render :json => result.to_json
      }
    end
  end

  def index
    @notes = Production::PurchaseQueueNote.by_date_desc.paginate(:page => params[:page], :per_page => 50)
  end

  def destroy
    @note = current_object
    @note.destroy
    flash[:notice] = "Note deleted"
    redirect_to purchase_queue_notes_url
  end

  protected

    def model_name
      :purchase_queue_note
    end

    def model_class
      Production::PurchaseQueueNote
    end

end
