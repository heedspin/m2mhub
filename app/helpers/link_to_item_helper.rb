module LinkToItemHelper
  def link_to_item(item, part_number=nil)
    if defined?(Obfuscator)
      part_number = Obfuscator.instance.part_number(part_number)
    end
    if item
      link_to_unless_current (part_number || item.part_number), item_url(item)
    else
      part_number
    end
  end
  def item_part_number(item)
    if defined?(Obfuscator)
      Obfuscator.instance.part_number(item.part_number)
    else
      item.part_number
    end
  end
end