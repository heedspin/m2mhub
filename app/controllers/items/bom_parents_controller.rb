class Items::BomParentsController < M2mhubController
  filter_access_to_defaults

  def index
    @item = parent_object
    @bom_items = M2m::BomItem.with_child_item(@item).by_parent_part_rev.paginate(:page => params[:page], :per_page => 20)
  end

  protected

    def model_class
      M2m::BomItem
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
