module LoggerUtils
  module Methods
    def loggers=(*args)
      @loggers = *args
    end
    def loggers
      @loggers ||= self.class.loggers.clone
    end
    def log(msg)
      self.loggers.each do |logger|
        logger.info "#{self.class.name.demodulize}: #{msg}"
      end
      msg
    end
  end
  def self.included(base)
    base.send(:include, Methods)
    base.class_eval <<-RUBY
    @@loggers = nil
    def self.loggers
      @@loggers ||= [AppConfig.delayed_job ? Delayed::Worker.logger : (ActiveRecord::Base.logger || Rails.logger)]
    end
    def self.log(msg)
      self.loggers.each do |logger|
        logger.info self.name.demodulize.to_s + ': ' + msg
      end
    end
    RUBY
  end
end
