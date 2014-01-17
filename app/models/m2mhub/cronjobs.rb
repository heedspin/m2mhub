require 'plutolib/stateless_delayed_job'
require 'quality/rma_inspection_runner'

class M2mhub::Cronjobs
  include Plutolib::StatelessDelayedJob

  # require 'm2mhub/cronjobs' ; M2mhub::Cronjobs.new.delay.high_frequency
  # */5 * * * * /var/www/htk/script/runner.sh 'M2mhub::Cronjobs.new.delay.medium_frequency'
  def high_frequency
    log "Running high_frequency"
    log "Finished high_frequency"
    true
  end
end
