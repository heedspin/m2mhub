module DelayedReport
  def self.included(base)
    base.class_eval <<-RUBY
      include LoggerUtils
      belongs_to :delayed_job, :class_name => 'Delayed::Backend::ActiveRecord::Job'
      before_save :save_string_logger
      extend ActiveHash::Associations::ActiveRecordExtensions
      belongs_to_active_hash :delayed_job_status, :class_name => 'DelayedJobStatus'
    RUBY
  end
  
  def run
    log "#{self.report_name} does nothing and does it beautifully!"
    # should_stop?
  end
  
  def report_name
    "#{self.class.name.demodulize.titleize} #{self.id}"
  end
  
  def set_loggers
    self.loggers.push self.string_logger
  end
  
  def set_delayed_job_status!(status=nil)
    if status.nil? or self.delayed_job_status != status
      self.delayed_job_status = status if status
      self.update_column(:delayed_job_status_id, self.delayed_job_status.id)  
    end
  end
  
  def delayed_job_main
    begin
      self.set_delayed_job_status! DelayedJobStatus.running
      self.set_loggers
      log "#{self.report_name} Starting"
      self.run
      self.delayed_job_status = DelayedJobStatus.complete if self.delayed_job_status.running?
      log "#{self.report_name} Finished with status #{self.delayed_job_status}"
      self.save
    rescue => exc
      backtrace = exc.respond_to?(:backtrace) ? exc.backtrace : []
      error_title = "#{self.report_name} exception: #{exc.class.name}: #{exc.message}"
      log "#{error_title}\n" + backtrace.join("\n")
      self.delayed_job_status = DelayedJobStatus.error
      self.save
      self.hopthetoad(error_title, backtrace)
      raise exc
    end    
  end
  
  def hopthetoad(error_title, backtrace=nil)
    if Rails.env.production?
      Airbrake.notify :error_class => self.report_name, :error_message => error_title, :backtrace => backtrace
    end
  end

  def run_in_background!
    self.delayed_job_status = DelayedJobStatus.queued
    if self.new_record?
      self.save
    else
      self.set_delayed_job_status!
    end
    if delayed_job = self.send_later(:delayed_job_main)
      self.delayed_job_id = delayed_job.id
      self.update_column(:delayed_job_id, delayed_job.id)
    end
  end
  
  def string_logger
    @string_logger ||= Logger.new(self.string_logger_buffer)
  end
  
  def truncate_string_logger_buffer
    self.string_logger_buffer.rewind
    txt = self.string_logger_buffer.read
    self.string_logger_buffer.rewind
    self.string_logger_buffer.truncate(0)
    txt
  end
  
  def string_logger_buffer
    @string_logger_buffer ||= StringIO.new
  end
  
  def save_string_logger
    txt = self.truncate_string_logger_buffer
    if txt.present?
      self.delayed_job_log = (self.delayed_job_log || '') + txt
      # logger.info txt
    end
  end
  
  def should_stop?
    self.reload
    self.push_status.stopped? || SignalHandler.instance.shutdown?
  end
  
end
