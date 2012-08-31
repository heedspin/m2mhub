require 'stateless_delayed_report'

class M2mhub::RunAllTriggers
  include StatelessDelayedReport

  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.run_report
  def run_report
    log "Updating event status"
    M2mhub::Event.open_or_recently_closed.each(&:update_status!)
    log "Running all triggers"
    total_events_created = 0
    M2mhub::Trigger.enabled.each do |trigger|
      total_events_created += trigger.run
    end
    log "Updating opportunity comments"
    Sales::OpportunityComment.open_tickets.each(&:update_status!)
    log "Finished.  Created #{total_events_created} events"
    true
  end
end
