require 'plutolib/stateless_delayed_job'
require 'quality/rma_inspection_runner'

class M2mhub::Cronjobs
  include Plutolib::StatelessDelayedJob

  # require 'm2mhub/cronjobs' ; M2mhub::Cronjobs.new.delay.high_frequency
  def high_frequency
    log "Running high_frequency"
    log "Finished high_frequency"
    true
  end

  # require 'm2mhub/cronjobs' ; M2mhub::Cronjobs.new.delay.medium_frequency
  def medium_frequency
    log "Running medium_frequency"
    if M2mhub::Feature.enabled?(:inspection_tasks)
      tasks = Quality::InspectionTask.status_open.all
      Quality::RmaInspectionRunner.new.run(tasks.select { |t| t.task_type.rma_inspection? })
      Quality::IncomingInspectionRunner.new.run(tasks.select { |t| t.task_type.incoming_inspection? })
      tasks.each(&:update_lighthouse_status!)
    end    
    log "Finished medium_frequency"
    true
  end
end
