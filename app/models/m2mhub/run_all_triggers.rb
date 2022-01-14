require 'plutolib/logger_utils'

# Cronhint:
# */5 8-17 * * 1-5 /var/www/lxdhub/script/runner.sh 'M2mhub::RunAllTriggers.new.delay.high_frequency'
# */15 8-17 * * 1-5 /var/www/lxdhub/script/runner.sh 'M2mhub::RunAllTriggers.new.delay.low_frequency'

class M2mhub::RunAllTriggers
  include Plutolib::LoggerUtils
  # require 'm2mhub/run_all_triggers' ; M2mhub::RunAllTriggers.new.high_frequency
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
    log "Finished"
    true
  end
end
