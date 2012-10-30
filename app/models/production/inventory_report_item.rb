# == Schema Information
#
# Table name: inventory_report_items
#
#  id                                     :integer(4)      not null, primary key
#  inventory_report_id                    :integer(4)
#  inventory_report_customer_id           :integer(4)
#  part_number                            :string(255)
#  revision                               :string(255)
#  m2m_identity_column                    :integer(4)
#  inventory_report_cost_method_id        :integer(4)
#  last_incoming_date                     :datetime
#  last_outgoing_date                     :datetime
#  next_outgoing_date                     :datetime
#  next_incoming_date                     :datetime
#  item_group_code_key                    :string(255)
#  last_incoming_inventory_transaction_id :integer(4)
#  next_sales_order_release_id            :integer(4)
#  last_sales_order_release_id            :integer(4)
#  movement_data                          :text
#  quantity_on_hand                       :decimal(12, 2)
#  quantity_committed                     :decimal(12, 2)
#  quantity_available                     :decimal(12, 2)
#  quantity_on_order                      :decimal(12, 2)
#  cost                                   :decimal(14, 4)
#

require 'm2m/belongs_to_item'
require 'm2m/belongs_to_item_group'
require 'active_hash'
require 'production/inventory_report_quantity'
require 'production/inventory_movement_data'

class Production::InventoryReportItem < ActiveRecord::Base
  set_table_name 'inventory_report_items'
  include ::BelongsToItem
  include ::BelongsToItemGroup # self.group, self.group_name, etc
  include Production::InventoryMovementData::Helper
  belongs_to_item
  belongs_to :inventory_report, :class_name => 'Production::InventoryReport'
  belongs_to :customer_report, :class_name => 'Production::InventoryReportCustomer', :foreign_key => 'inventory_report_customer_id'
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :inventory_report_cost_method, :class_name => 'Production::InventoryReportCostMethod'
  belongs_to :next_sales_order_release, :class_name => 'M2m::SalesOrderRelease', :foreign_key => 'next_sales_order_release_id'
  belongs_to :last_sales_order_release, :class_name => 'M2m::SalesOrderRelease', :foreign_key => 'last_sales_order_release_id'
  belongs_to :last_incoming_inventory_transaction, :class_name => 'M2m::InventoryTransaction', :foreign_key => 'last_incoming_inventory_transaction_id'

  scope :by_on_hand_cost_desc, :order => '(inventory_report_items.cost * inventory_report_items.quantity_on_hand) desc'
  scope :by_latest_activity, :select => "inventory_report_items.*,
  greatest(coalesce(last_outgoing_date, '1900-01-01'), coalesce(last_incoming_date, '1900-01-01'), coalesce(next_outgoing_date, '1900-01-01'), coalesce(next_incoming_date, '1900-01-01')) as latest_activity_date", :order => 'latest_activity_date'

  def latest_activity
    @latest_activity ||= [self.last_outgoing_date, self.last_incoming_date, self.next_outgoing_date, self.next_incoming_date].compact.max
  end
  
  attr_accessor :next_outgoing_parent_item
  def next_outgoing_parent_item
    unless @_loaded_next_outgoing_parent_item
      @next_outgoing_parent_item = M2m::Item.find(self.next_outgoing_parent_item_id)
      @_loaded_next_outgoing_parent_item = true
    end
    @next_outgoing_parent_item
  end
  def next_outgoing_parent_item=(val)
    @_loaded_next_outgoing_parent_item = true
    @next_outgoing_parent_item = val
  end

  attr_accessor :last_customer
  def run(item, past_releases, pending_sales, pending_purchases, inventory_transactions)
    @past_releases = past_releases
    @pending_sales = pending_sales
    @pending_purchases = pending_purchases
    self.item = item
    self.part_number = item.part_number
    self.revision = item.revision
    self.m2m_identity_column = item.identity_column
    [:quantity_on_hand, :quantity_committed, :quantity_available, :quantity_on_order].each do |key|
      self.send("#{key}=", item.send(key))
    end
    self.item_group_code_key = item.group_code_key
    self.choose_cost_method
    self.find_last_outgoing
    self.find_last_incoming_transaction
    self.find_next_outgoing
    self.next_incoming_date = @pending_purchases[item.part_number_revision]
    self.movements.add_transactions(inventory_transactions)
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
    self.cost = item.send(self.inventory_report_cost_method.item_key)
  end

  def find_last_outgoing
    if self.last_sales_order_release = @past_releases[self.item.part_number_revision]
      self.last_outgoing_date = self.last_sales_order_release.try(:last_ship_date)
      @last_customer = self.last_sales_order_release.sales_order.customer
    else
      self.last_outgoing_date = self.item.inventory_transactions.by_time_desc.outgoing.first.try(:time)
    end
  end

  def find_last_incoming_transaction
    # item.receiver_items.by_time_received_desc.scoped(:include => :receiver).first.try(:receiver).try(:time_received)
    if self.last_incoming_inventory_transaction = self.item.inventory_transactions.by_time_desc.incoming.first
      self.last_incoming_date = self.last_incoming_inventory_transaction.time
    end
  end

  def find_next_outgoing
    if self.next_sales_order_release = @pending_sales[self.item.part_number_revision]
      self.next_outgoing_date = self.next_sales_order_release.due_date
      # if (self.next_sales_order_release.part_number != self.item.part_number) or (self.next_sales_order_release.revision != self.item.revision)
      #   self.next_outgoing_parent_item = self.next_sales_order_release.item
      #   self.next_outgoing_parent_item_part_number = self.next_sales_order_release.part_number
      #   self.next_outgoing_parent_item_revision = self.next_sales_order_release.revision
      # end
    end
  end

  # def find_last_release(item, bom_depth=0)
  #   Production::InventoryStats.depth(0, bom_depth).total += 1
  #   release = nil
  #   if release = @past_releases[item.part_number_revision]
  #     Production::InventoryStats.depth(0, bom_depth).customer_from_release += 1
  #   else
  #     bom_releases = item.bom_parents.map do |bom_parent|
  #       find_last_release(bom_parent, bom_depth+1)
  #     end.compact
  #     if release = bom_releases.sort_by(&:last_ship_date).last
  #       Production::InventoryStats.depth(0, bom_depth).customer_from_bom += 1
  #     end
  #   end
  #   if release.nil?
  #     Production::InventoryStats.depth(0, bom_depth).no_customer += 1
  #   end
  #   release
  # end

  # def find_last_customer(item, job_depth=0, bom_depth=0)
  #   Production::InventoryStats.depth(job_depth, bom_depth).total += 1
  #   customer = nil
  #   release = M2m::SalesOrderRelease.for_item(item).by_last_ship_date_desc.scoped(:include => { :sales_order => :customer }).first
  #   if release
  #     customer = release.sales_order.customer
  #     Production::InventoryStats.depth(job_depth, bom_depth).customer_from_release += 1
  #   end
  #   if last_transaction = item.inventory_transactions.by_time_desc.outgoing.first
  #     if last_transaction.for_sales_order?
  #       if release and (last_transaction.sales_order_number == release.sales_order_number)
  #         Production::InventoryStats.depth(job_depth, bom_depth).transaction_to_same_release += 1
  #       else
  #         Production::InventoryStats.depth(job_depth, bom_depth).transaction_to_different_release += 1
  #       end
  #       if customer.nil?
  #         customer = last_transaction.sales_order.customer
  #         Production::InventoryStats.depth(job_depth, bom_depth).customer_from_transaction += 1
  #       end
  #     elsif last_transaction.for_job? and (job = last_transaction.job)
  #       if job.customer_number.present?
  #         Production::InventoryStats.depth(job_depth, bom_depth).transaction_to_job_to_customer += 1
  #         if customer.nil?
  #           customer = job.customer
  #           Production::InventoryStats.depth(job_depth, bom_depth).customer_from_job += 1
  #         end
  #       else
  #         Production::InventoryStats.depth(job_depth, bom_depth).job_recursing += 1
  #         customer = self.find_last_sales_order(job.item, job_depth+1, bom_depth)
  #       end
  #     else
  #       Production::InventoryStats.depth(job_depth, bom_depth).transaction_deadend += 1
  #     end
  #   else
  #     Production::InventoryStats.depth(job_depth, bom_depth).no_transaction += 1
  #     # Production::InventoryStats.depth(job_depth, bom_depth).no_transaction_items.push(item)
  #     item.bom_parents.each do |bom_parent|
  #       Production::InventoryStats.depth(job_depth, bom_depth).bom_recursing += 1
  #       customer = find_last_sales_order(bom_parent, job_depth, bom_depth+1)
  #       break if customer # TODO how to make this choose most recent?
  #     end
  #   end
  #   if customer.nil?
  #     Production::InventoryStats.depth(job_depth, bom_depth).no_customer += 1
  #   end
  #   customer
  # end

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
