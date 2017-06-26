require 'plutolib/comma'

module FormatHelper
  include Plutolib::Comma

  def cm_dollars(thing)
    if thing.round(2) != thing.round(3)
      cm(thing, :dollars_fraction)
    else
      cm(thing, :dollars)
    end
  end
  
  def cm(thing, company_config_key=nil, default=nil)
    if thing and (thing.to_f != 0)
      case thing
      when BigDecimal, Float, Fixnum
        if (company_config_key == :dollars) and (thing.round(2) != thing.round(3))
          comma(company_sprintf(thing, :dollars_fraction))
        else
          comma(company_sprintf(thing, company_config_key))
        end
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
    return nil unless text.present?
    text[0..(max-1)].strip + (text.size > max ? '...' : '')
  end
  
  def format_variable_time(time, today_format=:just_time, past_format=:number_date)
    return nil unless time
    now = Time.current
    today = (time.day == now.day) && (time.year == now.year)
    time.to_s(today ? today_format : past_format)
  end
  end