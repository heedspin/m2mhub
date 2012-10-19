require 'plutolib/logger_utils'
class M2mhub::TriggerRunnerBase
  include Plutolib::LoggerUtils
  def initialize(trigger)
    @trigger = trigger
  end
  def run
    0
  end
end