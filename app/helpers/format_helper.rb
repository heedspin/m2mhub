module FormatHelper
  # From http://rubyforge.org/snippet/detail.php?type=snippet&id=8
  def comma(thing)
    return '' if thing.nil?
    thing.to_s.gsub(/(\d)(?=\d{3}+(?:\D|$))/, '\\1,')
  end
  
  def cm(thing)
    if thing and (thing.to_i > 0)
      comma(thing)
    else
      nil
    end
  end
  
  def link_to_cm(thing, url)
    if (number = cm(thing)).present?
      link_to number, url
    else
      ''
    end
  end
  
  def comma_join(*args)
    args.select { |a| a.try(:strip).present? }.join(', ')
  end
  
end