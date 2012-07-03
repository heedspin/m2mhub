require 'logger_utils'

module StatelessDelayedReport
  def self.included(base)
    base.class_eval <<-RUBY
      include LoggerUtils
    RUBY
  end

  def run_in_background!
    self.send_later(:runner_main)
  end

  def runner_main
    begin
      log "Starting"
      self.run_report
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
  
  def run_report
    # Implement me!
  end
  
  protected
  
    def log_exception(exc)
      classname = self.class.name.humanize
      backtrace = exc.respond_to?(:backtrace) ? exc.backtrace : []
      error_title = "#{classname} exception: #{exc.class.name}: #{exc.message}"
      log "#{error_title}\n" + backtrace.join("\n")
      if Rails.env.production?
        Airbrake.notify :error_class => classname, :error_message => error_title, :backtrace => backtrace
      end
    end
end
