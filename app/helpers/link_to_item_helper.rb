module LinkToItemHelper
  def link_to_item(item, part_number)
    if item
      link_to part_number, item_url(item)
    else
      part_number
    end
  end
end