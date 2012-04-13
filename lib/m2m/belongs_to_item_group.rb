module BelongsToItemGroup
  def group
    M2m::ItemGroupCode.cached_lookup(self.group_code_key)
  end
  def group_name
    self.group.try(:text)
  end
  def short_group_name
    self.group.try(:short_text)
  end
  def finished_good?
    self.group_code_key.strip == 'FG'
  end
end