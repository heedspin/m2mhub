# == Schema Information
#
# Table name: inventory_report_items
#
#  id                              :integer(4)      not null, primary key
#  inventory_report_id             :integer(4)
#  inventory_report_customer_id    :integer(4)
#  part_number                     :string(255)
#  revision                        :string(255)
#  m2m_identity_column             :integer(4)
#  quantity_on_hand                :float
#  quantity_committed              :float
#  quantity_available              :float
#  quantity_on_order               :float
#  inventory_report_cost_method_id :integer(4)
#  cost                            :float
#  last_receipt_date               :datetime
#  last_ship_date                  :datetime
#  next_ship_date                  :datetime
#  next_receipt_date               :datetime
#

require 'm2m/belongs_to_item'
require 'production/inventory_report_quantity'
require 'active_hash'

class Production::InventoryReportItem < ActiveRecord::Base
  set_table_name 'inventory_report_items'
  include ::BelongsToItem
  belongs_to_item
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  belongs_to :customer_report, :class_name => 'Production::InventoryReportCustomer', :foreign_key => 'inventory_report_customer_id'
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :inventory_report_cost_method, :class_name => 'Production::InventoryReportCostMethod'
  
  scope :by_on_hand_cost_desc, :order => '(inventory_report_items.cost * inventory_report_items.quantity_on_hand) desc'
  scope :by_latest_activity, :select => "inventory_report_items.*, 
  greatest(coalesce(last_ship_date, '1900-01-01'), coalesce(last_receipt_date, '1900-01-01'), coalesce(next_ship_date, '1900-01-01'), coalesce(next_receipt_date, '1900-01-01')) as latest_activity_date", :order => 'latest_activity_date'
  
  def set_item(item, sales_order_releases, purchase_order_items)
    self.part_number = item.part_number
    self.revision = item.revision
    self.m2m_identity_column = item.identity_column
    [:quantity_on_hand, :quantity_committed, :quantity_available, :quantity_on_order].each do |key|
      self.send("#{key}=", item.send(key))
    end
    self.choose_cost_method
    self.cost = item.send(self.inventory_report_cost_method.item_key)
    self.last_ship_date = item.shipper_items.by_ship_date_desc.scoped(:include => :shipper).first.try(:shipper).try(:ship_date)
    self.last_receipt_date = item.receiver_items.by_time_received_desc.scoped(:include => :receiver).first.try(:receiver).try(:time_received)
    self.next_ship_date = sales_order_releases.sort_by(&:due_date).first.try(:due_date)
    self.next_receipt_date = purchase_order_items.sort_by(&:safe_promise_date).first.try(:safe_promise_date)
  end
  
  # Try default first.  Then just keep looking for something that has a value.
  # TODO: This does not allow zero value for anything...  Bad?
  def choose_cost_method
    unless (v = item.send(self.inventory_report_cost_method.item_key)).present? and (v > 0)
      Production::InventoryReportCostMethod.all.each do |cost_method|
        self.inventory_report_cost_method = cost_method
        if (v = item.send(self.inventory_report_cost_method.item_key)).present? and (v > 0)
          break
        end
      end
    end
  end
  
  Production::InventoryReportQuantity.all.each do |quantity|
    self.class_eval <<-RUBY
    def #{quantity.total_cost_key}
      result = (self.send('#{quantity.quantity_key}') || 0) * (self.cost || 0)
      # Do not allow negative cost.
      result < 0 ? 0 : result
    end
    RUBY
  end
end
