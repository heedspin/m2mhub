require 'logger_utils'
class M2mhub::TriggerRunnerBase
  include LoggerUtils
  def initialize(trigger)
    @trigger = trigger
  end
  def run
  end
end