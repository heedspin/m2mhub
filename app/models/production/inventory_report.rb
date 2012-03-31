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
#  earliest_release_date           :datetime
#

require 'delayed_report'
require 'active_hash_methods'
require 'bom_children_cache'

class Production::InventoryReport < ActiveRecord::Base
  TEST_MODE=false # Setting to true reduces sales order release cache size.
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
    if CompanyConfig.inventory_report_cost_method
      self.inventory_report_cost_method = Production::InventoryReportCostMethod.find_by_item_key(CompanyConfig.inventory_report_cost_method)
    end
    self.inventory_report_cost_method ||= Production::InventoryReportCostMethod.standard_cost
    self.save if self.new_record?

    no_customer = self.customer_reports.build(:customer_name => 'No Customer')
    @inventory_customers = { nil => no_customer }
    @inventory_items = []
    groups_to_filter = CompanyConfig.inventory_report_filter_groups.split(',').map(&:strip).map(&:downcase)
    part_numbers_to_filter = CompanyConfig.inventory_report_filter_part_numbers.split(',').map(&:strip).map(&:downcase)
    @bom_children = BomChildrenCache.new
    load_past_releases
    load_next_sales
    # puts self.next_sales.keys.map { |key| key.join('-') }.join(', ')
    # return 0
    # self.total_sales_order_releases = self.pending_sales.size
    pending_purchases = {}
    M2m::PurchaseOrderItem.filtered.status_open.find_each do |poitem|
      pending_purchases[[poitem.part_number, poitem.revision]] = poitem.safe_promise_date
    end
    self.total_purchase_order_items = pending_purchases.size

    self.total_on_hand_locations = 0
    reports_already_generated = Set.new
    M2m::InventoryLocation.with_quantity_on_hand.find_in_batches do |locations|
      # if locations = M2m::InventoryLocation.with_quantity_on_hand.limit(110)
      self.total_on_hand_locations += locations.size
      items = M2m::Item.attach_items(locations)
      # Remove non inventory items.
      items.delete_if { |i|
        groups_to_filter.include?(i.group_code_key.strip.downcase) ||
        part_numbers_to_filter.include?(i.part_number.downcase) ||
        reports_already_generated.member?(i.part_number_revision)
      }

      items.each do |item|
        inventory_item = Production::InventoryReportItem.new(:inventory_report_cost_method => self.inventory_report_cost_method,
                                                             :inventory_report_id => self.id)
        @inventory_items.push inventory_item
        reports_already_generated.add(item.part_number_revision)
        inventory_item.run(item, self.past_releases, self.next_sales, pending_purchases)
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
        add_next_sale(release.part_number, release.revision, release)
        bom_children.each do |bom_item|
          add_next_sale(bom_item.part_number, bom_item.revision, release)
        end
      end
    end
  end

  # Only keep the earliest release.
  def add_next_sale(part_number, revision, release)
    item_key = [part_number, revision]
    if (exists = self.next_sales[item_key]).nil? or (exists.due_date > release.due_date)
      self.next_sales[item_key] = release
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
      releases = M2m::SalesOrderRelease.by_last_ship_date_desc.scoped(:include => { :sales_order => :customer }).limit(1000).offset(offset)
      offset += releases.size
      @bom_children.for_releases(releases).each do |release, bom_children|
        if (self.earliest_release_date.nil? or (release.last_ship_date < self.earliest_release_date))
          self.earliest_release_date = release.last_ship_date
        end
        add_past_release(release.part_number, release.revision, release)
        bom_children.each do |bom_item|
          add_past_release(bom_item.part_number, bom_item.revision, release)
        end
      end
    end
  end

  # Only keep the earliest release.
  def add_past_release(part_number, revision, release)
    item_key = [part_number, revision]
    if (exists = self.past_releases[item_key]).nil? or (exists.due_date > release.due_date)
      self.past_releases[item_key] = release
    end
  end

  def past_releases
    @past_releases ||= {}
  end

end
