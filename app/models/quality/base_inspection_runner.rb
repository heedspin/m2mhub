require 'plutolib/logger_utils'
require 'plutolib/comma'
class Quality::BaseInspectionRunner
  include Plutolib::Comma
  include Plutolib::LoggerUtils
  def handle_receipt(task, receipt)
    if task.last_receiver.nil? or (task.last_receiver.time_received < receipt.time_received)
      # New receipt
      task.last_receiver_id = receipt.id
      task.status = Quality::InspectionTaskStatus.in_inspection
      quantity = receipt.items.select { |i| i.part_number == task.part_number }.sum(&:quantity)
      task.update_ticket "Received #{comma(quantity)} #{task.part_number} at #{receipt.time_received.to_s(:short_human_date_time)}\nReceiver: #{receipt.receiver_number}"
      task.lighthouse_watcher_update
      task.save!
    end
  end
end