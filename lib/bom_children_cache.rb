class BomChildrenCache
  def initialize
    @cache = {}
  end
  def for_releases(releases)
    result = {}
    hits = []
    misses = []
    caches = []
    # Add to result from cache
    releases_to_load = []
    releases.each do |release|
      item_key = [release.part_number, release.revision]
      release.instance_variable_set :@item_key, [release.part_number, release.revision]
      if children = @cache[item_key]
        result[release] = children
        hits.push item_key
      else
        releases_to_load.push release
        misses.push item_key
        false
      end
    end
    bom_items = {}
    M2m::BomItem.with_parent_part_numbers(releases_to_load.map(&:part_number).uniq).each do |bom_item|
      (bom_items[[bom_item.parent_part_number, bom_item.parent_revision]] ||= []).push(bom_item)
    end
    releases_to_load.each do |release|
      item_key = release.instance_variable_get :@item_key
      @cache[item_key] = result[release] = (bom_items[item_key] || [])
      caches.push item_key
    end
    # puts 'Hits: ' + hits.map { |h| h.join('-') }.join(', ')
    # puts 'Misses: ' + misses.map { |m| m.join('-') }.join(', ')
    # puts 'Caches: ' + caches.map { |c| c.join('-') }.join(', ')
    result
  end
end