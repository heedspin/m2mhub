class Items::BomsController < M2mhubController
  filter_access_to_defaults

  def index
    @item = parent_object
    parent_scope = M2m::BomItem.with_child_item(@item)
    @bom_parents = parent_scope.by_parent_part_rev.limit(20)
    @total_bom_parents = parent_scope.count
    child_scope = M2m::BomItem.with_parent_item(@item)
    @bom_children = child_scope.by_child_part_rev.limit(50)
    @total_bom_children = child_scope.count
  end

  protected

    def model_class
      M2m::BomItem
    end

    def parent_object
      @parent_object ||= M2m::Item.find(params[:item_id])
    end
    
end
