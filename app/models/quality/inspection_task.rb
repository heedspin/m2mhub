# == Schema Information
#
# Table name: inspection_tasks
#
#  id                                 :integer          not null, primary key
#  part_number                        :string(255)
#  revision                           :string(255)
#  quantity                           :decimal(14, 4)
#  title                              :string(255)
#  body                               :text
#  task_type_id                       :integer
#  purchase_order_number              :string(255)
#  purchase_order_item_number         :string(255)
#  purchase_order_item_id             :string(255)
#  rma_number                         :integer
#  rma_item_number                    :string(255)
#  rma_item_id                        :string(255)
#  rma_customer_name                  :string(255)
#  date_expected                      :datetime
#  last_receiver_id                   :string(255)
#  status_id                          :integer
#  lighthouse_ticket_id               :string(255)
#  lighthouse_project_id              :string(255)
#  lighthouse_project_name            :string(255)
#  lighthouse_milestone               :string(255)
#  lighthouse_status                  :string(255)
#  lighthouse_closed                  :boolean
#  lighthouse_url                     :string(255)
#  lighthouse_title                   :string(255)
#  lighthouse_last_comment            :text
#  lighthouse_last_updated_at         :datetime
#  lighthouse_last_updater            :string(255)
#  lighthouse_last_assigned_user_name :string(255)
#  created_at                         :datetime
#  updated_at                         :datetime
#

require 'm2mhub/lighthouse_watcher'
require 'plutolib/comma'

class Quality::InspectionTask < M2mhub::Base
  set_table_name 'inspection_tasks'
  include M2mhub::LighthouseWatcher
  include Plutolib::Comma
  validates_presence_of :part_number
  
  belongs_to_active_hash :status, :class_name => 'Quality::InspectionTaskStatus'
  belongs_to_active_hash :task_type, :class_name => 'Quality::InspectionTaskType'
  belongs_to_item
  belongs_to :rma, :class_name => 'M2m::Rma', :foreign_key => 'rma_number', :primary_key => 'fcrmano'
  belongs_to :last_receiver, :class_name => 'M2m::Receiver', :foreign_key => :last_receiver_id, :primary_key => :freceiver
  belongs_to :purchase_order_item, :class_name => 'M2m::PurchaseOrderItem'
  belongs_to :purchase_order, :class_name => 'M2m::PurchaseOrder', :foreign_key => :purchase_order_number

  attr_accessor :create_lighthouse_ticket
  attr_accessor :lighthouse_assigned_user_id
  attr_accessor :lighthouse_body
  attr_accessor :lighthouse_milestone_id
  attr_accessor :delete_lighthouse_ticket
  
  scope :not_deleted, :conditions => [ 'inspection_tasks.status_id != ?', Quality::InspectionTaskStatus.deleted.id ]
  scope :task_type, lambda { |task_type|
    {
      :conditions => { :task_type_id => task_type.id }
    }
  }
  scope :status_open, :conditions => [ 'inspection_tasks.status_id in (?)', Quality::InspectionTaskStatus.open_ids ]
  scope :purchase_order_number, lambda { |ponums|
    {
      :conditions => [ 'inspection_tasks.purchase_order_number in (?)', ponums ]
    }
  }
  def self.friendly_purchase_order_number(ponum)
    padded = M2m::PurchaseOrder.pad_purchase_order_number(ponum)
    non_padded = ponum.to_i
    where(['(inspection_tasks.purchase_order_number = ? or inspection_tasks.purchase_order_number = ?)', padded, non_padded])
  end
  scope :status, lambda { |s|
    s = Quality::InspectionTaskStatus.find(s) unless s.is_a?(Quality::InspectionTaskStatus)
    status_ids = s.children_ids || [s.id]
    {
      :conditions => [ 'inspection_tasks.status_id in (?)', status_ids ]
    }
  }
  scope :rma_number, lambda { |num|
    rma_numbers = num.is_a?(Enumerable) ? num : [ num ]
    {
      :conditions => [ 'inspection_tasks.rma_number in (?)', rma_numbers.map { |n| M2m::Rma.pad_rma_number(n) }]
    }
  }
  def self.part_number(txt)
    where(:part_number => txt)
  end
  
  before_save :fill_in_details
  def fill_in_details
    unless self.title.present?
      self.title = self.task_type.name + ': ' + self.part_number
    end
    if self.task_type.rma_inspection?
      if self.rma_number.present? and self.rma.present?
        if self.rma_customer_name.blank?
          self.rma_customer_name = self.rma.customer_name
        end
        if self.quantity.blank?
          self.rma.items.each do |rma_item|
            logger.debug rma_item.inspect
            if self.item.same_item?(rma_item) and (self.quantity.nil? or (rma_item.quantity == self.quantity)) and (self.rma_item_number.blank? or (self.rma_item_number == rma_item.item_number))
              self.quantity = rma_item.quantity
              self.rma_item_number = rma_item.item_number
              self.rma_item_id = rma_item.id
            end
          end
        end
      end
    else
    end
  end
  
  def destroy
    if self.lighthouse_ticket and attribute_to_boolean(self.delete_lighthouse_ticket)
      self.lighthouse_ticket.destroy
    end
    self.status = Quality::InspectionTaskStatus.deleted
    if self.purchase_order_item and self.purchase_order_item.inspection_required?
      self.purchase_order_item.update_attributes(:inspection_required => 'N')
    end
    self.save
  end
  
  def update_lighthouse_status!
    self.lighthouse_watcher_update
    if self.changed?
      self.save!
    else
      true
    end
  end
  
  before_save :handle_lighthouse
  def handle_lighthouse
    if attribute_to_boolean(self.create_lighthouse_ticket)
      if self.lighthouse_body =~ /lighthouseapp.com\/projects\/(\d+)[^\/]*\/tickets\/(\d+)/
        # Import the ticket and change our comment type.
        project_id = $1
        ticket_id = $2
        if self.lighthouse_ticket = Lighthouse::Ticket.find(ticket_id, :params => { :project_id => project_id })
          self.lighthouse_ticket_id = ticket_id
          self.lighthouse_project_id = project_id
          self.lighthouse_watcher_update
        end
      elsif self.lighthouse_project_id.present?
        self.lighthouse_milestone_id ||= self.task_type.rma_inspection? ? AppConfig.inspection_task_default_lighthouse_rma_milestone : AppConfig.inspection_task_default_lighthouse_incoming_milestone
        self.lighthouse_watcher_create(self.lighthouse_title, self.lighthouse_body, self.lighthouse_assigned_user_id, self.lighthouse_milestone_id)
      else
        false
      end
    else
      true
    end
  end
  
  def update_ticket(text)
    if self.lighthouse_ticket
      log "Updating lighthouse ticket Project #{self.lighthouse_project.try(:name)} #{self.lighthouse_ticket}: #{text}"
      self.lighthouse_ticket.body = text
      self.lighthouse_ticket.status = 'open'
      if self.lighthouse_ticket.save
        log "Successfully updated lighthouse ticket #{self.lighthouse_ticket}"
      else
        log_error "Failed to update lighthouse ticket #{self.lighthouse_ticket}"
        false
      end
    else
      false
    end
  end
  
  def self.attach_to_rmas(rmas)
    rmas.each { |rma| rma.inspection_task = false } # set all to false
    rma_numbers = rmas.map(&:rma_number)
    Quality::InspectionTask.task_type(Quality::InspectionTaskType.rma_inspection).not_deleted.rma_number(rma_numbers).each do |inspection_task|
      if rma = rmas.detect { |r| r.rma_number == inspection_task.rma_number }
        rma.inspection_task = inspection_task
      end
    end
  end
  
  def initialize_from_purchase_order_item(poi)
    self.status = Quality::InspectionTaskStatus.awaiting_receipt
    self.task_type = Quality::InspectionTaskType.incoming_inspection
    self.title = "#{self.task_type.name}: #{poi.part_number}"
    self.part_number = poi.part_number
    self.purchase_order_number = poi.purchase_order_number
    self.purchase_order_item_id = poi.id
    self.quantity = poi.backorder_quantity
    self.date_expected = poi.last_promise_date || poi.original_promise_date

    url = Rails.application.routes.url_helpers.inspection_tasks_url(:poi => poi.id, :host => AppConfig.hostname)
    body = []
    body.push "PO #{self.purchase_order_number} for #{comma(poi.quantity)} #{poi.part_number}"
    body.push "Currently due: #{self.date_expected.to_s(:database)}"
    task_body = body.join("\n")
    body.push "[M2MHub Inspection Task](#{url})"
    body.push "\n---"
    body.push AppConfig.inspection_task_default_incoming_inspection_comment
    ticket_body = body.join("\n")
    self.create_lighthouse_ticket = true
    self.lighthouse_project_id = AppConfig.inspection_task_default_lighthouse_project
    self.lighthouse_assigned_user_id = AppConfig.inspection_task_default_lighthouse_user
    self.lighthouse_milestone_id = AppConfig.inspection_task_default_lighthouse_incoming_milestone
    self.lighthouse_title = self.title
    self.lighthouse_body = ticket_body
    self.body = task_body
    true
  end
  
  after_create :set_inspection_required_flag
  def set_inspection_required_flag
    logger.info "#{self.task_type.incoming_inspection?} #{self.purchase_order_item_id}"
    if self.task_type.incoming_inspection? and (poi = M2m::PurchaseOrderItem.find(self.purchase_order_item_id)) and !poi.inspection_required?
      if poi.update_attributes(:inspection_required => 'Y')
        logger.info "inspection_required success"
      else
        logger.info "inspection_required failure"
      end
    end
  end
  
end
