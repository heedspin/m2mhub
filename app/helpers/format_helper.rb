require 'plutolib/comma'
module FormatHelper
  include Plutolib::Comma
  
  def cm(thing, company_config_key=nil, default=nil)
    if thing and (thing.to_f != 0)
      case thing
      when BigDecimal, Float, Fixnum
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
    company_format = AppConfig.get(key) || '%.1f'
    if company_format.starts_with?('trim_decimals')
      company_format = num.to_i == num ? '%0.f' : (company_format.split(',')[1] || '%.1f')
    end
    num && sprintf(company_format, num)
  end

  def percent0(num)
    num && sprintf("%.0f",num * 100)
  end

  def percent1(num)
    num && sprintf("%.1f",num * 100)
  end
  
  def set_focus(input_id)
    html = <<-HTML
    <script type="text/javascript">
    $(document).ready(function(){
      $('#{input_id}').focus();
    });    
    </script>
    HTML
    content_for :javascripts, html.html_safe
  end
  
  # Shorten, truncate, add ellipse...
  def limit_string(text, max)
    text[0..(max-1)] + (text.size > max ? '...' : '')
  end
end
