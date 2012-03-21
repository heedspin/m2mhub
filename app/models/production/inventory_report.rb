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
#  total_on_hand_locations         :integer(4)
#  total_run_time_seconds          :integer(4)
#  total_sales_order_releases      :integer(4)
#  total_purchase_order_items      :integer(4)
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
    report_start_time = Time.now.to_i
    self.inventory_report_cost_method ||= Production::InventoryReportCostMethod.standard_cost
    self.save if self.new_record?

    no_customer = self.customer_reports.build(:customer_name => 'No Customer')
    @inventory_customers = { nil => no_customer }
    groups_to_filter = CompanyConfig.inventory_report_filter_groups.split(',').map(&:strip).map(&:downcase)
    part_numbers_to_filter = CompanyConfig.inventory_report_filter_part_numbers.split(',').map(&:strip).map(&:downcase)
    releases = M2m::SalesOrderRelease.filtered.status_open.not_filled.to_a
    self.total_sales_order_releases = releases.size
    purchase_order_items = M2m::PurchaseOrderItem.filtered.status_open.to_a
    self.total_purchase_order_items = purchase_order_items.size

    self.total_on_hand_locations = 0
    M2m::InventoryLocation.with_quantity_on_hand.find_in_batches do |locations|
    # locations = M2m::InventoryLocation.with_quantity_on_hand.limit(1000)
    # if true
      self.total_on_hand_locations += locations.size
      items = M2m::Item.attach_items(locations)
      # Remove non inventory items.
      items.delete_if { |i| groups_to_filter.include?(i.group_code_key.strip.downcase) || part_numbers_to_filter.include?(i.part_number.downcase) }

      items.each do |item|
        allocated_to_customer = choose_customer(item)
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
    end # end location batches

    @inventory_customers.values.each do |inventory_customer|
      self.add_to_totals(inventory_customer)
      inventory_customer.save
    end
    self.total_run_time_seconds = Time.now.to_i - report_start_time
    self.save

    if CompanyConfig.inventory_report_use_boms
      Rails.logger.info 'BOM Stats: ' + self.bom_stats.values.map(&:to_s).join(', ')
    end
  end

  def choose_customer(item)
    if result = item.last_customer
      result
    elsif CompanyConfig.inventory_report_use_boms
      find_first_ancestor_customer(item)
    else
      nil
    end
  end

  class DepthStat
    attr_accessor :depth, :queries, :hits
    def initialize(depth)
      @depth = depth
      @queries = 0
      @hits = 0
    end
    def to_s
      "Depth #{self.depth}: #{self.hits} / #{self.queries}"
    end
  end
  def bom_stats_for(depth)
    if @bom_stats.nil?
      @bom_stats = { :more => DepthStat.new(:more),
                     :misses => DepthStat.new(:misses) }
      for d in 1..4
        @bom_stats[d] = DepthStat.new(d)
      end
    end
    @bom_stats[depth] || @bom_stats[:more]
  end
  attr_accessor :bom_stats

  def find_first_ancestor_customer(item, depth=1)
    stats = bom_stats_for(depth)
    stats.queries += 1

    parents = M2m::BomItem.with_child_item(item).map(&:parent_item).compact
    parents.each do |item_parent|
      if result = item_parent.last_customer
        stats.hits += 1
        return result
      end
    end
    parents.each do |item_parent|
      if result = find_first_ancestor_customer(item_parent, depth+1)
        return result
      end
    end
    if depth == 1
      bom_stats_for(:misses).queries += 1
    end
    nil
  end

end
