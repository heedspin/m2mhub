class BomChildrenCache
  def initialize
    @cache = {}
  end
  def for_releases(releases)
    if CompanyConfig.use_boms
      result = {}
      # hits = []
      # misses = []
      # caches = []
      # Add to result from cache
      releases_to_load = []
      releases.each do |release|
        if children = @cache[release.part_number_revision]
          result[release] = children
          # hits.push item_key
        else
          releases_to_load.push release
          # misses.push item_key
          false
        end
      end
      bom_items = {}
      M2m::BomItem.with_parent_part_numbers(releases_to_load.map(&:part_number).uniq).each do |bom_item|
        (bom_items[bom_item.parent_part_number_parent_revision] ||= []).push(bom_item)
      end
      releases_to_load.each do |release|
        @cache[release.part_number_revision] = result[release] = (bom_items[release.part_number_revision] || [])
        # caches.push release.part_number_revision
      end
      # puts 'Hits: ' + hits.map { |h| h.join('-') }.join(', ')
      # puts 'Misses: ' + misses.map { |m| m.join('-') }.join(', ')
      # puts 'Caches: ' + caches.map { |c| c.join('-') }.join(', ')
      result
    else
      releases.map { |r| [r, []] }
    end
  end
end