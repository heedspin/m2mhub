# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def item_url(part_number)
    super part_number.strip.gsub('/','%2F')
  end
end
