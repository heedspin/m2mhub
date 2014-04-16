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
  # */5 8-17 * * 1-5 /var/www/lxdhub/script/runner.sh 'M2mhub::Cronjobs.new.delay.medium_frequency'
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
  
  # */15 8-17 * * 1-5 /var/www/lxdhub/script/runner.sh 'M2mhub::Cronjobs.new.delay.low_frequency'
  def low_frequency
    log "Running low_frequency"
    log "Updating opportunity comments"
    Sales::ErpCustomerMatcher.new.run_report
    Sales::SalesOrderAssigner.new.run_report
    log "Finished low_frequency"
  end
  
  # 02 1 * * * /var/www/lxdhub/script/runner.sh 'M2mhub::Cronjobs.new.delay.nightly'
  def nightly
    log "Running nightly"
    log "Running opportunity run_notifications"
    Sales::Opportunity.run_notifications
    log "Running rep report"
    Sales::RepReportRunner.new.run_report
    log "Running invoice discrepancy report"
    Finance::InvoiceDiscrepancyReportRunner.new.run_report
    log "Running opportunity grim reaper"
    Sales::Opportunity.run_reaper
    log "Running Doogle sync_all_to_erp"
    Doogle::Display.sync_all_to_erp
    log "Finished nightly"
  end
end
