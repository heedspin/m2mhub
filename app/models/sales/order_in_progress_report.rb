# Sales::OrderInProgressReport::Runner.new.run_report
# Sales::OrderInProgressReportRunner.new.run_in_backgroun!
require 'plutolib/active_hash_transient_belongs_to'
require 'plutolib/to_xls'
require 'plutolib/logger_utils'

class Sales::OrderInProgressReport
  include Plutolib::ActiveHashTransientBelongsTo
  include Plutolib::ToXls

  ATTRIBUTES = %w(due_date due_after sales_order_numbers page_per_customer releases fob_group_id customer_status_id backlog_group_id include_jobs_id sort_order_id)  
  
  def initialize(args=nil)
    args ||= {}
    ATTRIBUTES.each do |att|
      self.send("#{att}=", args[att])
    end
    self.sort_order_id ||= Shipping::BacklogSortOrder.customer_so_pn.id    
    @releases ||= []
  end
  
  ATTRIBUTES.each do |att|
    attr_accessor att
  end
  
  def page_per_customer=(val)
    @page_per_customer = val.is_a?(String) ? (val.to_i != 0) : val
  end
  
  # active_hash_transient_belongs_to :report_status, :class_name => 'ReportStatus'
  active_hash_transient_belongs_to :fob_group
  active_hash_transient_belongs_to :customer_status, :class_name => 'M2m::CustomerStatus'
  active_hash_transient_belongs_to :backlog_group
  active_hash_transient_belongs_to :sort_order, :class_name => 'Shipping::BacklogSortOrder'
  active_hash_transient_belongs_to :include_jobs, :class_name => 'Shipping::IncludeJobs'

  def run
    @releases = M2m::SalesOrderRelease.filtered.status_open.not_filled.due_by(self.due_date)
    if self.due_after.present?
      @releases = @releases.due_after(self.due_after)
    end
    if self.sales_order_numbers.present? and (so_numbers = self.sales_order_numbers.split(/[ ,]/).compact) and (so_numbers.size > 0)
      @releases = @releases.sales_order_numbers(so_numbers)
    end
    @releases = @releases.includes(:sales_order => :customer).order(self.sort_order.order_sql).to_a
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

  def xls_sheet_name
    'SO In Progress'
  end

  def xls_initialize
    xls_field('Customer') { |r| r.sales_order.customer_name }
    xls_field('SO') { |r| r.sales_order_number }
    xls_field('Ship Date') { |r| r.due_date.to_s(:sales_date) }
    xls_field('Part Number') { |r| r.part_number }
    xls_field('Order Qty') { |r| r.quantity }
    xls_field('Shipped Qty') { |r| r.quantity_shipped }
    xls_field('Backordered Qty') { |r| r.backorder_quantity }
    xls_field('On Hand') { |r| r.item.item.quantity_on_hand }
    xls_field('In Progress') { |r| r.item.item.quantity_in_process }
    xls_field('Committed') { |r| r.item.item.quantity_committed }
    xls_field('Unit Std Cost', xls_dollar_format) { |r| r.item.item.standard_cost }
    xls_field('Total Std Cost', xls_dollar_format) { |r| r.item.item.standard_cost * r.quantity }
    xls_field('Jobs') { |r| 
      result = []
      r.jobs.each do |job|
        job_result = ["Job #{job.job_number}"]
        job.detail_routings.each do |dr|
          job_result.push "  #{dr.work_center_id.strip}: #{dr.percentage_complete}% #{dr.quantity_complete.to_i} #{dr.fprod_val}"
        end
        result.push job_result.join("\n")
      end
      result.join("\n")
    }
  end

  class ReleaseHelper
    attr :release
    def initialize(report, release)
      @report = report
      @release = release
    end
    def method_missing(mid, *args)
      @release.send(mid, *args)
    end
    def jobs
      @jobs ||= M2m::Job.for_item(self.item.item).status(@report.include_jobs.job_status).by_date_desc.all
    end
  end

  def xls_data
    self.run
    @releases.map { |r| ReleaseHelper.new(self, r) }
  end

  class Runner
    include Plutolib::LoggerUtils

    def run_report
      report = Sales::OrderInProgressReport.new
      report.due_date ||= Date.current.next_week
      report.sort_order_id ||= Shipping::BacklogSortOrder.customer_so_pn.id
      report.include_jobs ||= Shipping::IncludeJobs.open

      report.to_xls File.join(AppConfig.default_report_directory, "#{AppConfig.short_name} SO In Progress.xls")
    end
  end


end
