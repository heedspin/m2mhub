require 'm2mhub_current_user'

class M2mhub::Feature
  class Config
    attr_accessor :name
    def initialize(name)
      @name = name
      config_string = AppConfig.get("feature_#{@name}")
      @config = if config_string.nil? or config_string.is_a?(FalseClass)
        false
      elsif (config_string == 'all') or (config_string.is_a?(TrueClass))
        true
      else
        Set.new config_string.split(',').map(&:strip).compact
      end
    end
    
    def enabled?(user)
      @config.is_a?(Set) ? @config.member?(user.email) : @config
    end
  end
  
  class << self
    def enabled?(feature)
      self.feature_config(feature.to_s).try(:enabled?, M2mhubCurrentUser.user)
    end
    
    def feature_config(feature)
      @feature_configs ||= Hash.new
      @feature_configs[feature] ||= M2mhub::Feature::Config.new(feature)
    end
  end
end