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
#

require 'm2m/belongs_to_item'
require 'production/inventory_report_quantity'
require 'active_hash'

class Production::InventoryReportItem < ActiveRecord::Base
  set_table_name 'inventory_report_items'
  include ::BelongsToItem
  belongs_to_item
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  belongs_to :customer_report, :class_name => 'Production::InventoryReportCustomer'
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :inventory_report_cost_method, :class_name => 'Production::InventoryReportCostMethod'
  
  def set_item(item)
    self.part_number = item.part_number
    self.revision = item.revision
    self.m2m_identity_column = item.identity_column
    [:quantity_on_hand, :quantity_committed, :quantity_available, :quantity_on_order].each do |key|
      self.send("#{key}=", item.send(key))
    end
    self.choose_cost_method
    self.cost = item.send(self.inventory_report_cost_method.item_key)
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
