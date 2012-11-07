require 'plutolib/stateless_delayed_report'

class M2mhub::RunAllTriggers
  include Plutolib::StatelessDelayedReport

  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.run_report
  def high_frequency
    log "Running triggers"
    total_events_created = 0
    M2mhub::Trigger.enabled.each do |trigger|
      total_events_created += trigger.run
    end
    log "Created #{total_events_created} events"
    true
  end

  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.run_report
  def low_frequency
    log "Updating event status"
    M2mhub::Event.open_or_recently_closed.each(&:update_status!)
    log "Updating opportunity comments"
    Sales::OpportunityComment.to_monitor.each { |c| Sales::OpportunityComment.find(c.id).update_status! }
    log "Finished"
    true
  end
end
