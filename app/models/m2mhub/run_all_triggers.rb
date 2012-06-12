require 'logger_utils'

class M2mhub::RunAllTriggers
  include LoggerUtils

  def run_in_background!
    self.send_later(:run_triggers)
  end

  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.run_triggers
  def run_triggers
    begin
      log "Running all triggers"
      M2mhub::Trigger.enabled.each do |trigger|
        trigger.run
      end
      log "Finished"
      true
    rescue Exception => exc
      log_exception exc
      raise exc
    rescue => exc
      log_exception exc
      raise exc
    end
  end
  
  protected
  
    def log_exception(exc)
      backtrace = exc.respond_to?(:backtrace) ? exc.backtrace : []
      error_title = "Trigger exception: #{exc.class.name}: #{exc.message}"
      log "#{error_title}\n" + backtrace.join("\n")
      if Rails.env.production?
        Airbrake.notify :error_class => "M2mhub Triggers", :error_message => error_title, :backtrace => backtrace
      end
    end
end
