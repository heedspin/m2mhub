require 'stateless_delayed_report'

class M2mhub::RunAllTriggers
  include StatelessDelayedReport

  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.run_report
  def run_report
    log "Updating event status"
    M2mhub::Event.open_or_recently_closed.each do |event|
      event.update_status!
    end
    log "Running all triggers"
    M2mhub::Trigger.enabled.each do |trigger|
      trigger.run
    end
    log "Finished"
    true
  end
end
