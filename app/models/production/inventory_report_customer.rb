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
#

class Production::InventoryReportCustomer < ActiveRecord::Base
  include Production::InventoryReportQuantity::Helper
  set_table_name 'inventory_report_customers'
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  has_many :item_reports, :class_name => 'Production::InventoryReportItem'
  scope :by_on_hand_desc, :order => 'inventory_report_customers.total_on_hand_cost desc'
end
