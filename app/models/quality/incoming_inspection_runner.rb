class Quality::IncomingInspectionRunner < Quality::BaseInspectionRunner
  def run(open_tasks=nil)
    @open_tasks = open_tasks || Quality::InspectionTask.status_open.task_type(Quality::InspectionTaskType.incoming_inspection).all
    find_new_purchase_orders
    find_inspection_receipts
  end

  def find_new_purchase_orders
    # Testing setup:
    # open_inspection_required = M2m::PurchaseOrderItem.filtered.status_closed.inspection_required(true).select('pomast.fpono').order('pomast.fpono').limit(1).map(&:purchase_order_number)
    open_inspection_required = M2m::PurchaseOrderItem.filtered.status_open.inspection_required(true).select('pomast.fpono').map(&:purchase_order_number)
    existing_tasks = Quality::InspectionTask.not_deleted.purchase_order_number(open_inspection_required).select('purchase_order_number').map(&:purchase_order_number)
    new_pos = open_inspection_required - existing_tasks
    if new_pos.size > 0
      type = Quality::InspectionTaskType.incoming_inspection
      log 'Creating incoming inspection tasks for ' + new_pos.join(', ')
      M2m::PurchaseOrderItem.where(['fpono in (?)', new_pos]).inspection_required(true).includes(:purchase_order).each do |poi|
        title = "#{type.name}: #{poi.part_number}"
        task = Quality::InspectionTask.new(:status => Quality::InspectionTaskStatus.awaiting_receipt,
                                           :task_type => type,
                                           :part_number => poi.part_number,
                                           :purchase_order_number => poi.purchase_order_number,
                                           :quantity => poi.quantity,
                                           :title => title,
                                           :date_expected => poi.last_promise_date || poi.original_promise_date)
        task.save!
        url = Rails.application.routes.url_helpers.inspection_task_url(task, :host => AppConfig.hostname)
        body = []
        body.push "PO #{task.purchase_order_number} for #{comma(poi.quantity)} #{poi.part_number}"
        body.push "Currently due: #{task.date_expected.to_s(:database)}"
        task_body = body.join("\n")
        body.push "[M2MHub Inspection Task](#{url})"
        body.push "\n---"
        body.push AppConfig.inspection_task_default_incoming_inspection_comment
        ticket_body = body.join("\n")
        task.update_attributes( :create_lighthouse_ticket => true,
                                :lighthouse_project_id => AppConfig.inspection_task_default_lighthouse_project,
                                :lighthouse_assigned_user_id => AppConfig.inspection_task_default_lighthouse_user,
                                :lighthouse_milestone_id => AppConfig.inspection_task_default_lighthouse_incoming_milestone,
                                :lighthouse_title => title,
                                :lighthouse_body => ticket_body,
                                :body => task_body )
      end
    end
    true
  end

  def find_inspection_receipts
    open_tasks = @open_tasks.select { |t| t.purchase_order_number.present? }
    log "#{open_tasks.size} open incoming inspection tasks. PO's: " + open_tasks.map(&:purchase_order_number).join(', ')
    if open_tasks.size > 0
      all_receipts = M2m::Receiver.purchase_order_number(open_tasks.map(&:purchase_order_number)).all
      all_receipts.map(&:purchase_order_number).uniq.select(&:present?).each do |pono|
        unless task = open_tasks.detect { |t| M2m::PurchaseOrder.pad_purchase_order_number(t.purchase_order_number) == pono }
          raise "Unable to find task with purchase order number #{pono}"
        end
        receipts = all_receipts.select { |r| r.purchase_order_number == pono }
        log "#{receipts.size} receivers found for PO #{pono}"
        receipts.sort_by(&:time_received).each do |receiver|
          self.handle_receipt(task, receiver)
        end
      end
    end
  end
end
