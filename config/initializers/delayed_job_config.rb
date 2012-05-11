Delayed::Worker.max_attempts = 1
Delayed::Worker.max_run_time = 6.hours
Delayed::Worker.logger = ActiveSupport::BufferedLogger.new("log/#{Rails.env}_delayed_jobs.log", Rails.logger.level)
Delayed::Worker.logger.auto_flushing = 1
if caller.last =~ /.*\/script\/delayed_job:\d+$/
  AppConfig.delayed_job = true
  ActiveRecord::Base.logger = Delayed::Worker.logger
else
  AppConfig.delayed_job = false
end
Delayed::Worker.logger.info "DelayedJobConfig: called from #{caller.last}.  delayed_job = #{AppConfig.delayed_job}"
if Rails.env.development?
  Delayed::Worker.destroy_failed_jobs = false
end
