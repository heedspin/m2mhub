require 'plutolib/active_hash_transient_belongs_to'

class Shipping::BacklogReport
  include Plutolib::ActiveHashTransientBelongsTo

  ATTRIBUTES = %w(due_date due_after sales_order_numbers page_per_customer releases fob_group_id customer_status_id backlog_group_id)  
  
  def initialize(args)
    args ||= {}
    ATTRIBUTES.each do |att|
      self.send("#{att}=", args[att])
    end
    @releases ||= []
  end
  
  ATTRIBUTES.each do |att|
    attr_accessor att
  end
  
  # active_hash_transient_belongs_to :report_status, :class_name => 'ReportStatus'
  active_hash_transient_belongs_to :fob_group
  active_hash_transient_belongs_to :customer_status, :class_name => 'M2m::CustomerStatus'
  active_hash_transient_belongs_to :backlog_group

  def run
    @releases = M2m::SalesOrderRelease.filtered.status_open.not_filled.due_by(self.due_date)
    if self.due_after.present?
      @releases = @releases.due_after(self.due_after)
    end
    if self.sales_order_numbers.present? and (so_numbers = self.sales_order_numbers.split(/[ ,]/).compact) and (so_numbers.size > 0)
      @releases = @releases.sales_order_numbers(so_numbers)
    end
    @releases = @releases.includes(:sales_order => :customer).order('somast.fcompany, sorels.fsono, sorels.fpartno').to_a
    sales_order_items = M2m::SalesOrderItem.for_releases(@releases).to_a
    M2m::SalesOrderItem.attach_to_releases_for_backlog(@releases, sales_order_items)
    items = M2m::Item.attach_items(sales_order_items)

    # This will get too many locations, but will be filtered with revision by InventoryLocation.attach_to_items.
    locations = M2m::InventoryLocation.with_part_numbers(items.map(&:part_number)).to_a
    M2m::InventoryLocation.attach_to_items(locations, items)

    # Filter
    @releases = @releases.select do |r|
      if self.backlog_group and self.backlog_group.filter_release?(r)
        false
      else
        correct_group = self.fob_group.nil? || self.fob_group.member?(r.sales_order.fob)
        correct_status = self.customer_status.nil? || (r.sales_order.customer.status == self.customer_status)
        # debugger if Breakpoints.buc && (customer.fcstatus == 'H')
        correct_group && correct_status
      end
    end
  end
  
  def self.human_attribute_name(field)
    I18n.t "activerecord.attributes.shipping/backlog_report.#{field}", :default => field.humanize
  end
  
end

# == Schema Information
#
# Table name: sales_backlog_reports
#
#  id                 :integer(4)      not null, primary key
#  due_date           :date
#  report_status_id   :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  fob_group_id       :integer(4)
#  customer_status_id :integer(4)
#  due_after          :date
#  page_per_customer  :boolean(1)
#  backlog_group_id   :integer(4)
#
