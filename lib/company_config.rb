require 'singleton'

class CompanyConfigClass
  def initialize
    @company_key = if Rails.root.to_s.include?('lxd_m2mhub')
      'lxd'
    else
      'smt'
    end
  end
  
  def company_key
    @company_key
  end
  
  def method_missing(mid, *args)
    if mid.to_s =~ /(.+)\?$/
      val = get($1)
      if val.nil?
        return false
      elsif val.is_a?(FalseClass) or val.is_a?(TrueClass)
        return val
      else
        return !['0', 'false', 'nil'].include?(val.downcase)
      end
    else
      get(mid)
    end
  end

  # Check environment-specific setting first.  Then check shared setting.
  def get(key)
    key = key.to_s
    if (c = AppConfig.company_config[@company_key]) && (value = c[key]).present?
      value
    elsif (c = AppConfig.shared_company_config[@company_key]) && (value = c[key]).present?
      value
    else
      nil
    end
  end

end

::CompanyConfig = CompanyConfigClass.new
