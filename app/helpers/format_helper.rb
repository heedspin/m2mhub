module FormatHelper
  # From http://rubyforge.org/snippet/detail.php?type=snippet&id=8
  def comma(thing)
    return '' if thing.nil?
    thing.to_s.gsub(/(\d)(?=\d{3}+(?:\D|$))/, '\\1,')
  end

  def cm(thing, company_config_key=nil, default=nil)
    if thing and (thing.to_i > 0)
      case thing
      when BigDecimal, Float
        comma(company_sprintf(thing, company_config_key))
      else
        comma(thing)
      end
    else
      default
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

  def company_sprintf(num, key)
    return num unless key
    company_format = CompanyConfig.get(key) || '%.1f'
    num && sprintf(company_format, num)
  end

  def percent0(num)
    num && sprintf("%.0f",num * 100)
  end

  def percent1(num)
    num && sprintf("%.1f",num * 100)
  end
end
