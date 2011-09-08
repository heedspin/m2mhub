require 'ostruct'
require 'yaml'

unless defined?(::AppConfig)
  class AppConfigStruct < OpenStruct
    def initialize(args)
      super
    end
    def method_missing(mid, *args)
      if mid.to_s =~ /(.+)\?$/
        val = send($1)
        if val.nil?
          return false
        elsif val.is_a?(FalseClass) or val.is_a?(TrueClass)
          return val
        else
          return !['0', 'false', 'nil'].include?(val.downcase)
        end
      else
        super
      end
    end
  end
  config_hash = {}
  config_file = File.join(Rails.root, 'config', 'app_config.yml')
  if File.exist?(config_file)
    if (contents = YAML::load(ERB.new(IO.read(config_file)).result)) and (not contents.nil?)  
      if contents.has_key? Rails.env.downcase
        contents = contents[Rails.env.downcase]
      end
      config_hash.merge! contents
    end
  end
  ::AppConfig = AppConfigStruct.new(config_hash)
end

