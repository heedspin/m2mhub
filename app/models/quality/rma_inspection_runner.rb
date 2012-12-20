require 'plutolib/logger_utils'
require 'plutolib/comma'
class Quality::RmaInspectionRunner < Quality::BaseInspectionRunner
  def run(open_tasks)
    open_tasks = open_tasks.select { |t| t.rma_number.present? }
    log "#{open_tasks.size} open rma inspection tasks: " + open_tasks.map(&:rma_number).join(', ')
    if open_tasks.size > 0
      all_receipts = M2m::Receiver.rma_number(open_tasks.map(&:rma_number)).all
      all_receipts.map(&:rma_number).uniq.select(&:present?).each do |rma_number|
        unless task = open_tasks.detect { |t| M2m::Rma.pad_rma_number(t.rma_number) == rma_number }
          raise "Unable to find task with rma number #{rma_number}"
        end
        receipts = all_receipts.select { |r| r.rma_number == rma_number }
        receipts.sort_by(&:time_received).each do |receiver|
          self.handle_receipt(task, receiver)
        end
      end
    end
  end
end