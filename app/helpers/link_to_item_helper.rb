module LinkToItemHelper
  def link_to_item(item, part_number)
    if defined?(Obfuscator)
      part_number = Obfuscator.instance.part_number(part_number)
    end
    if item
      link_to_unless_current part_number, item_url(item)
    else
      part_number
    end
  end
end