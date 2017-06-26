# == Schema Information
#
# Table name: inventory_report_customers
#
#  id                   :integer          not null, primary key
#  inventory_report_id  :integer
#  customer_name        :string(255)
#  customer_number      :string(255)
#  m2m_identity_column  :integer
#  movement_data        :text
#  total_on_hand_cost   :decimal(12, 2)
#  total_on_order_cost  :decimal(12, 2)
#  total_available_cost :decimal(12, 2)
#  total_committed_cost :decimal(12, 2)
#

require 'production/inventory_report_quantity'
require 'production/inventory_movement_data'

class Production::InventoryReportCustomer < ActiveRecord::Base
  self.table_name = 'inventory_report_customers'
  include Production::InventoryReportQuantity::Helper
  include Production::InventoryMovementData::Helper
  
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  has_many :item_reports, :class_name => 'Production::InventoryReportItem'
  scope :by_on_hand, -> { order('total_on_hand_cost') }
  scope :by_on_hand_desc, -> order('inventory_report_customers.total_on_hand_cost desc') }
  scope :with_less_onhand, -> (inventory_report_customer) {
    [ 'inventory_report_customers.total_on_hand_cost < ? and inventory_report_customers.id != ?', inventory_report_customer.total_on_hand_cost, inventory_report_customer.id ]
  }
  scope :with_more_onhand, -> (inventory_report_customer) {
    where [ 'inventory_report_customers.total_on_hand_cost > ? and inventory_report_customers.id != ?', inventory_report_customer.total_on_hand_cost, inventory_report_customer.id ]
  }
end
