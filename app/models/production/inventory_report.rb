# == Schema Information
#
# Table name: inventory_reports
#
#  id                              :integer          not null, primary key
#  delayed_job_id                  :integer
#  delayed_job_status_id           :integer
#  delayed_job_log                 :text
#  created_at                      :datetime
#  updated_at                      :datetime
#  inventory_report_cost_method_id :integer
#  total_run_time_seconds          :integer
#  earliest_release_date           :datetime
#  movement_data                   :text
#  report_date                     :date
#  total_on_hand_cost              :decimal(12, 2)
#  total_on_order_cost             :decimal(12, 2)
#  total_available_cost            :decimal(12, 2)
#  total_committed_cost            :decimal(12, 2)
#

require 'plutolib/stateful_delayed_report'
require 'plutolib/to_xls'
require 'bom_children_cache'
require 'production/inventory_report_quantity'
require 'production/inventory_movement_data'

class Production::InventoryReport < ActiveRecord::Base
  TEST_MODE=false # Setting to true reduces sales order release cache size.
  self.table_name = 'inventory_reports'
  include Plutolib::ToXls
  include Plutolib::StatefulDelayedReport
  include Production::InventoryReportQuantity::Helper
  include Production::InventoryMovementData::Helper
  has_many :customer_reports, :class_name => '::Production::InventoryReportCustomer', :dependent => :destroy
  has_many :item_reports, :class_name => '::Production::InventoryReportItem', :dependent => :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :inventory_report_cost_method, :class_name => '::Production::InventoryReportCostMethod'

  scope :by_date_desc, :order => 'inventory_reports.report_date desc, inventory_reports.created_at desc'

  def run_report
    report_start_time = Time.now.to_i
    if AppConfig.cost_method
      self.inventory_report_cost_method = Production::InventoryReportCostMethod.find_by_item_key(AppConfig.cost_method)
    end
    self.inventory_report_cost_method ||= Production::InventoryReportCostMethod.standard_cost
    self.save if self.new_record?

    no_customer = self.customer_reports.build(:customer_name => 'No Customer')
    @inventory_customers = { nil => no_customer }
    @inventory_items = []
    groups_to_filter = AppConfig.inventory_report_filter_groups.split(',').map(&:strip).map(&:downcase)
    part_numbers_to_filter = AppConfig.inventory_report_filter_part_numbers.split(',').map(&:strip).map(&:downcase)
    @bom_children = BomChildrenCache.new
    load_past_releases
    load_next_sales
    pending_purchases = {}
    M2m::PurchaseOrderItem.filtered.status_open.find_each do |poitem|
      pending_purchases[[poitem.part_number, poitem.revision]] = poitem.safe_promise_date
    end

    @inventory_transactions = {}
    self.report_date ||= Time.current.hour < 12 ? Date.current.advance(:days => -1) : Date.current
    M2m::InventoryTransaction.between(self.report_date, self.report_date.advance(:days => 1)).each do |it|
      (@inventory_transactions[it.part_number_revision] ||= []).push it
    end

    reports_already_generated = Set.new
    M2m::InventoryLocation.with_quantity_on_hand.find_in_batches do |locations|
      # if locations = M2m::InventoryLocation.with_quantity_on_hand.limit(110)
      items = M2m::Item.attach_items(locations)
      # Remove non inventory items.
      items.delete_if { |i|
        result = (groups_to_filter.include?(i.group_code_key.strip.downcase) ||
                  part_numbers_to_filter.include?(i.part_number.downcase) ||
                  reports_already_generated.member?(i.part_number_revision))
        unless result
          reports_already_generated.add(i.part_number_revision)
        end
        result
      }

      items.each do |item|
        inventory_item = Production::InventoryReportItem.new(:inventory_report_cost_method => self.inventory_report_cost_method,
                                                             :inventory_report_id => self.id)
        @inventory_items.push inventory_item
        inventory_item.run(item, self.past_releases, self.next_sales, pending_purchases, @inventory_transactions[item.part_number_revision])
        last_customer = inventory_item.last_customer
        inventory_customer = @inventory_customers[last_customer.try(:customer_number)]
        if inventory_customer.nil?
          inventory_customer = self.customer_reports.build(:customer_number => last_customer.customer_number,
                                                           :customer_name => last_customer.name,
                                                           :m2m_identity_column => last_customer.identity_column)
          @inventory_customers[last_customer.customer_number] = inventory_customer
        end
        inventory_customer.add_to_totals inventory_item
        inventory_item.customer_report = inventory_customer
      end
    end

    @inventory_customers.values.each do |inventory_customer|
      self.add_to_totals(inventory_customer)
      inventory_customer.save if inventory_customer.changed?
    end
    @inventory_items.map(&:save)
    self.total_run_time_seconds = Time.now.to_i - report_start_time
    self.save
  end

  def load_next_sales
    release_scope = if TEST_MODE
      M2m::SalesOrderRelease.filtered.status_open.not_filled.due_by(Date.current.advance(:months => 1))
    else
      M2m::SalesOrderRelease.filtered.status_open.not_filled
    end
    release_scope.find_in_batches(:batch_size => 500) do |releases|
      M2m::Item.attach_items(releases)
      @bom_children.for_releases(releases).each do |release, bom_children|
        add_next_sale(release.part_number_revision, release)
        bom_children.each do |bom_item|
          add_next_sale(bom_item.part_number_revision, release)
        end
      end
    end
  end

  # Only keep the earliest release.
  def add_next_sale(part_number_revision, release)
    if (exists = self.next_sales[part_number_revision]).nil? or (exists.due_date > release.due_date)
      self.next_sales[part_number_revision] = release
    end
  end

  def next_sales
    @next_sales ||= {}
  end

  MAX_PAST_RELEASES = TEST_MODE ? 500 : 18000 # arbitrary.  it's about two years worth for smt.
  def load_past_releases
    offset = 0
    while offset < MAX_PAST_RELEASES
      # find_in_batches breaks sorting
      releases = M2m::SalesOrderRelease.scoped(:include => { :sales_order => :customer }).limit(1000).offset(offset)
      break if releases.size == 0
      offset += releases.size
      @bom_children.for_releases(releases).each do |release, bom_children|
        next unless release.last_ship_date # skip it unless it's actually shipped
        if (self.earliest_release_date.nil? or (release.due_date < self.earliest_release_date))
          self.earliest_release_date = release.due_date
        end
        keep_most_recent_release(release.part_number_revision, release)
        bom_children.each do |bom_item|
          keep_most_recent_release(bom_item.part_number_revision, release)
        end
      end
    end
  end

  def keep_most_recent_release(part_number_revision, release)
    if (exists = self.past_releases[part_number_revision]).nil? or (release.last_ship_date > exists.last_ship_date)
      self.past_releases[part_number_revision] = release
    end
  end

  def past_releases
    @past_releases ||= {}
  end
  
  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    cost_format = Spreadsheet::Format.new(:number_format => '$#,##0.000')
    xls_field("Part Number") { |r| r.part_number_and_revision }
    xls_field('Part Description') { |r| r.item.try(:description) }
    xls_field('Group') { |r| r.item.try(:short_group_name) }
    never = Date.parse('1901-01-01')
    xls_field('Latest Activity Date') { |r| r.latest_activity || never }
    xls_field('On Hand Cost', dollar_format) { |r| r.total_on_hand_cost }
    xls_field('Last Customer') { |r| r.customer_report.try(:customer_name) }
    xls_field('Quantity On Hand') { |r| r.quantity_on_hand }
    xls_field('Committed Cost', dollar_format) { |r| r.total_committed_cost }
    xls_field('Quantity Committed') { |r| r.quantity_committed }
    xls_field('Available Cost', dollar_format) { |r| r.total_available_cost }
    xls_field('Quantity Available') { |r| r.quantity_available }
    xls_field('Total On Order') { |r| r.total_on_order_cost }
    xls_field('Quantity On Order') { |r| r.quantity_on_order }
    xls_field('Unit Cost', cost_format) { |r| r.cost.to_f.round(3) }
    xls_field('Last Receipt', xls_date_format) { |r| r.last_incoming_date }
    xls_field('Last Ship', xls_date_format) { |r| r.last_outgoing_date }
    xls_field('Last Sales Order') { |r| r.last_sales_order_release.try(:sales_order_number) }
    xls_field('Next Receipt', xls_date_format) { |r| r.next_incoming_date }
    xls_field('Next Ship', xls_date_format) { |r| r.next_outgoing_date }
    xls_field('Next Sales Order') { |r| r.next_sales_order_release.try(:sales_order_number) }
  end
  
  def all_data
    self.item_reports
  end
  
  def xls_filename
    "#{report_date.to_s(:sortable)}_#{AppConfig.short_name}_inventory"
  end

end
