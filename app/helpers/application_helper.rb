# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_item(item, part_number)
    if item
      link_to part_number, item_url(item)
    else
      part_number
    end
  end
  
  def customer_number_url(custno)
    customer_url(:id => custno, :custno => true)
  end
end
