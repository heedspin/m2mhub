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
      log 'Creating incoming inspection tasks for ' + new_pos.join(', ')
      M2m::PurchaseOrderItem.where(['[fpono] in (?)', new_pos]).inspection_required(true).includes(:purchase_order).each do |poi|
        task = Quality::InspectionTask.new
        task.initialize_from_purchase_order_item(poi)
        task.save!
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
