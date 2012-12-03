class M2mhub::Feature
  class Config
    attr_accessor :name
    def initialize(name)
      @name = name
      config_string = AppConfig.get("feature_#{@name}")
      @config = if(config_string == 'all')
        'all'
      else
        Set.new config_string.split(',').map(&:strip).compact
      end
    end
    
    def enabled?(user)
      (@config == 'all') || @config.member?(user.email)
    end
  end
  
  class << self
    attr_accessor :current_user
    def enabled?(feature)
      current_user.present? && self.feature_config(feature).try(:enabled?, current_user)
    end
    
    def feature_config(feature)
      @feature_configs ||= Hash.new
      @feature_configs[feature] ||= M2mhub::Feature::Config.new(feature)
    end
  end
end