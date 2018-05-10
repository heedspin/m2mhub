# Production::WorkInProgressReport::Runner.new.run_report
# Production::WorkInProgressReport::Runner.new.delay.run_report
require 'plutolib/active_hash_transient_belongs_to'
require 'plutolib/to_xls'
require 'plutolib/logger_utils'

class Production::WorkInProgressReport
  include Plutolib::ActiveHashTransientBelongsTo
  include Plutolib::ToXls

  ATTRIBUTES = %w(include_jobs_id)  
  
  def initialize(args=nil)
    args ||= {}
    ATTRIBUTES.each do |att|
      self.send("#{att}=", args[att])
    end
  end
  
  ATTRIBUTES.each do |att|
    attr_accessor att
  end
  
  active_hash_transient_belongs_to :include_jobs, :class_name => 'Shipping::IncludeJobs'

  def xls_sheet_name
    'WIP'
  end

  def xls_initialize
    xls_field('Job No') { |j| j.job_number }
    xls_field('Status') { |j| j.status.name }
    xls_field('Part Number') { |j| j.part_number }
    xls_field('Job Qty') { |j| j.quantity }
    xls_field('Act Cost', xls_dollar_format) { |j| j.actual_cost }
    xls_field('Act Material', xls_dollar_format) { |j| j.actual_material_cost }
    xls_field('Act Sub', xls_dollar_format) { |j| j.actual_sub_cost }
    xls_field('Act Labor', xls_dollar_format) { |j| j.actual_labor_cost }
    xls_field('Act Overhead', xls_dollar_format) { |j| j.actual_overhead_cost }
    xls_field('Estimated Cost', xls_dollar_format) { |j| j.price_summary.total_cost }
    xls_field('Standard Total Cost', xls_dollar_format) { |j| j.total_cost }
    %w(material_cost sub_cost fixed_cost other_cost labor_cost overhead_cost overhead_set_cost setup_cost).each do |key|
      xls_field('Est ' + key.to_s.titleize, xls_dollar_format) { |j| j.price_summary.send(key) }
    end
    %w(material_cost sub_cost fixed_cost other_cost labor_cost overhead_cost).each do |key|
      xls_field("Std #{key.to_s.titleize}", xls_dollar_format) { |j| j.send(key) }
    end
    xls_field('Routing') { |j| 
      job_result = ["Job #{j.job_number}"]
      j.cached_detail_routings.each do |dr|
        job_result.push "  #{M2m::WorkCenter.cached_lookup(dr.work_center_id).name}: #{dr.percentage_complete}% #{dr.quantity_complete.to_i}"
      end
      job_result.join("\n")
    }
    xls_field('Unit Std Cost', xls_dollar_format) { |j| j.item.try(:standard_cost) }
    xls_field('On Hand') { |j| j.item.try(:quantity_on_hand) }
    xls_field('In Progress') { |j| j.item.try(:quantity_in_process) }
    xls_field('Committed') { |j| j.item.try(:quantity_committed) }
  end

  def xls_data
    jobs = M2m::Job.status(self.include_jobs.job_status).by_date_desc.includes(:price_summary, :purchase_order_items)
    if AppConfig.wip_report_ignore_jobs
      jobs = jobs.job_number_not(AppConfig.wip_report_ignore_jobs.split(' '))
    end
    jobs.each_slice(100) do |jobs_in_slice|
      jm = {}
      jobs_in_slice.each { |j| jm[j.job_number] = j }
      M2m::DailyLaborDetail.attach(jm)
      M2m::JobDetailRouting.attach(jm)
      M2m::JobDetailBom.attach(jm)
      M2m::Item.attach_items(jobs)
    end
    jobs
  end

  class Runner
    include Plutolib::LoggerUtils

    def run_report
      report = Production::WorkInProgressReport.new
      report.include_jobs ||= Shipping::IncludeJobs.open
      report.to_xls File.join(AppConfig.wip_report_directory, "#{AppConfig.short_name} WIP.xls")
    end
  end

end
