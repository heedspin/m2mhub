module LoggerUtils
  module Methods
    def logger
      @logger || self.class.logger
    end
    def logger=(l)
      @logger = l
    end
    def log(msg)
      if @logger
        @logger.info "#{self.class.name.demodulize}: #{msg}"
      else
        self.class.log(msg)
      end
    end
  end
  def self.included(base)
    base.send(:include, Methods)
    base.class_eval <<-RUBY
    @@logger = nil
    def self.logger=(l)
      @@logger = l
    end
    def self.logger
      @@logger ||= AppConfig.delayed_job ? Delayed::Worker.logger : (ActiveRecord::Base.logger || Rails.logger)
    end
    def self.log(msg)
      self.logger.info self.name.demodulize.to_s + ': ' + msg
    end
    RUBY
  end
end
