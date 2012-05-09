class AppConfigClass
  def initialize
    config_file = File.join(Rails.root, 'config', 'main_config.yml')
    if File.exist?(config_file)
      @yaml_config = YAML::load(ERB.new(IO.read(config_file)).result)
    else
      @yaml_config = {}
    end
  end
  
  def method_missing(mid, *args)
    mid = mid.to_s
    if mid =~ /(.+)\?$/
      val = get($1)
      if val.nil?
        return false
      elsif val.is_a?(FalseClass) or val.is_a?(TrueClass)
        return val
      else
        return !['0', 'false', 'nil'].include?(val.downcase)
      end
    elsif mid[mid.size-1, mid.size-1] == '='
      set_local(mid[0,mid.size-1], args.first)
    else
      get(mid)
    end
  end
  
  def set_local(key, value)
    ((@yaml_config['local_config'] ||= {})[Rails.env.downcase] ||= {})[key] = value
  end

  # Check environment-specific setting first.  Then check shared setting.
  def get(key)
    key = key.to_s
    %w(local_config app_config).each do |config_key|
      if (config = @yaml_config[config_key]) and (config = config[Rails.env.downcase]) and config.member?(key)
        return config[key]
      end
    end
    if (config = @yaml_config['m2m_config']) and config.member?(key)
      return config[key]
    end
    nil
  end
end

::AppConfig = AppConfigClass.new

