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
        @note.save!
        render :action => 'show'
      }
    end
  end

  def show
    @note = current_object
    respond_to do |format|
      format.html
      format.json
    end
  end
  
  def edit
    @note = current_object
  end
  
  def update
    @note = current_object
    respond_to do |format|
      format.html {
        if @note.update_attributes(params[:purchase_queue_note])
          redirect_to purchase_queue_note_url(@note)
        else
          render :action => 'new'
        end        
      }
      format.js {
        @note.update_attributes(params[:purchase_queue_note])
        render :action => 'show'
      }
    end
  end    

  def index
    @notes = Production::PurchaseQueueNote.by_date_desc.paginate(:page => params[:page], :per_page => 50)
  end

  def destroy
    old_note = current_object
    old_note.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "Note deleted"
        redirect_to purchase_queue_notes_url        
      }
      format.js {
        @note = Production::PurchaseQueueNote.new(:part_number => old_note.part_number, :revision => old_note.revision)
        render :action => 'show'
      }
    end
  end

  protected

    def model_name
      :purchase_queue_note
    end

    def model_class
      Production::PurchaseQueueNote
    end

end
