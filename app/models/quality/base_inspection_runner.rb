require 'plutolib/logger_utils'
require 'plutolib/comma'
class Quality::BaseInspectionRunner
  include Plutolib::Comma
  include Plutolib::LoggerUtils
  def handle_receipt(task, receipt)
    begin
      if task.last_receiver.nil? or (task.last_receiver.time_received < receipt.time_received)
        task.last_receiver_id = receipt.id
        task.status = Quality::InspectionTaskStatus.in_inspection
        quantity = receipt.items.select { |i| i.part_number == task.part_number }.sum(&:quantity)
        if quantity > 0
          log "New receipt"
          task.update_ticket "Received #{comma(quantity)} #{task.part_number} at #{receipt.time_received.to_s(:short_human_date_time)}\nReceiver: #{receipt.receiver_number}"
          task.lighthouse_watcher_update
          task.save!
        end
      else
        log "Old receipt"
      end
    rescue
      log_error "Unexpected error in handle_receipt", $!
    end
  end
end