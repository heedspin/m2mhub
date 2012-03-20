# == Schema Information
#
# Table name: inventory_reports
#
#  id                              :integer(4)      not null, primary key
#  delayed_job_id                  :integer(4)
#  delayed_job_status_id           :integer(4)
#  delayed_job_log                 :text
#  created_at                      :datetime
#  updated_at                      :datetime
#  inventory_report_cost_method_id :integer(4)
#  total_on_hand_cost              :float
#  total_on_order_cost             :float
#  total_available_cost            :float
#  total_committed_cost            :float
#

require 'delayed_report'
require 'active_hash_methods'

class Production::InventoryReport < ActiveRecord::Base
  set_table_name 'inventory_reports'
  include DelayedReport
  include Production::InventoryReportQuantity::Helper
  has_many :customer_reports, :class_name => '::Production::InventoryReportCustomer', :dependent => :destroy
  has_many :item_reports, :class_name => '::Production::InventoryReportItem', :dependent => :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :inventory_report_cost_method, :class_name => '::Production::InventoryReportCostMethod'

  scope :by_date_desc, :order => 'inventory_reports.created_at desc'

  def run
    self.inventory_report_cost_method ||= Production::InventoryReportCostMethod.standard_cost
    self.save if self.new_record?

    no_customer = self.customer_reports.build
    @inventory_customers = { nil => no_customer }

    locations = M2m::InventoryLocation.with_quantity_on_hand
    items = M2m::Item.attach_items(locations)

    releases = M2m::SalesOrderRelease.filtered.status_open.not_filled.to_a
    purchase_order_items = M2m::PurchaseOrderItem.filtered.status_open.to_a
    
    # Remove non inventory items.
    groups_to_filter = CompanyConfig.inventory_report_filter_groups.split(',').map(&:strip).map(&:downcase)
    part_numbers_to_filter = CompanyConfig.inventory_report_filter_part_numbers.split(',').map(&:strip).map(&:downcase)
    items.delete_if { |i| groups_to_filter.include?(i.group_code_key.strip.downcase) || part_numbers_to_filter.include?(i.part_number.downcase) }

    items.each do |item|
      allocated_to_customer = item.customers.first
      inventory_customer = @inventory_customers[allocated_to_customer.try(:customer_number)]
      if inventory_customer.nil?
        inventory_customer = self.customer_reports.build(:customer_number => allocated_to_customer.customer_number,
                                                         :customer_name => allocated_to_customer.name,
                                                         :m2m_identity_column => allocated_to_customer.identity_column)
        @inventory_customers[allocated_to_customer.customer_number] = inventory_customer
      end
      inventory_item = inventory_customer.item_reports.build(:inventory_report_cost_method => self.inventory_report_cost_method,
                                                             :inventory_report_id => self.id)
      inventory_item.set_item(item,
                              releases.select { |r| r.is_for_item?(item) },
                              purchase_order_items.select { |p| p.is_for_item?(item) })
      inventory_customer.add_to_totals inventory_item
    end
    @inventory_customers.values.each do |inventory_customer|
      self.add_to_totals(inventory_customer)
      inventory_customer.save
    end
    self.save
  end

end
