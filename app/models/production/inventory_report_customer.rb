# == Schema Information
#
# Table name: inventory_report_customers
#
#  id                   :integer(4)      not null, primary key
#  inventory_report_id  :integer(4)
#  customer_name        :string(255)
#  customer_number      :string(255)
#  m2m_identity_column  :integer(4)
#  total_on_hand_cost   :float
#  total_on_order_cost  :float
#  total_available_cost :float
#  total_committed_cost :float
#  movement_data        :text
#

require 'production/inventory_report_quantity'
require 'production/inventory_movement_data'

class Production::InventoryReportCustomer < ActiveRecord::Base
  set_table_name 'inventory_report_customers'
  include Production::InventoryReportQuantity::Helper
  include Production::InventoryMovementData::Helper
  
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  has_many :item_reports, :class_name => 'Production::InventoryReportItem'
  scope :by_on_hand, :order => 'total_on_hand_cost'
  scope :by_on_hand_desc, :order => 'inventory_report_customers.total_on_hand_cost desc'  
  scope :with_less_onhand, lambda { |inventory_report_customer|
    {
      :conditions => [ 'inventory_report_customers.total_on_hand_cost < ? and inventory_report_customers.id != ?', inventory_report_customer.total_on_hand_cost, inventory_report_customer.id ]
    }
  }
  scope :with_more_onhand, lambda { |inventory_report_customer|
    {
      :conditions => [ 'inventory_report_customers.total_on_hand_cost > ? and inventory_report_customers.id != ?', inventory_report_customer.total_on_hand_cost, inventory_report_customer.id ]
    }
  }
end
