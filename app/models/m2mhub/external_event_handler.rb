require 'plutolib/logger_utils'

class M2mhub::ExternalEventHandler
  include Plutolib::LoggerUtils
  
  attr_accessor :external_event
  def initialize(external_event)
    @external_event = external_event
  end
  
  def self.handler_class(external_event)
    if @handler_classes.nil?
      @handler_classes = {}
      (AppConfig.external_event_handlers || {}).each do |source_key, handler_class_name|
        @handler_classes[source_key] = handler_class_name.constantize
      end
    end
    @handler_classes[external_event.source_type] || @handler_classes['default']
  end 
  
  def run_main
    begin
      self.run
    rescue => exc
      @external_event.status = M2mhub::ExternalEventStatus.error
      log_error 'External Event failed', exc
    end
  end
end

