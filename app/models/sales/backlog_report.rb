# == Schema Information
#
# Table name: backlog_reports
#
#  id            :integer          not null, primary key
#  date          :date
#  total_backlog :decimal(12, 2)
#  created_at    :datetime
#  updated_at    :datetime
#  data          :text
#

require 'plutolib/serialized_attributes'
require 'plutolib/to_xls'

class Sales::BacklogReport < M2mhub::Base
  include Plutolib::SerializedAttributes
  include Plutolib::ToXls
  self.table_name = 'backlog_reports'
  belongs_to_active_hash :report_time_period
  scope :date, -> (date) {
    where :date => date
  }
  scope :time_period, -> (report_time_period) {
    where :report_time_period_id => report_time_period.id
  }
  scope :by_date_desc, -> { order('backlog_reports.date desc') }

  def run!
    memos = []
    self.total_backlog = late = 0.0
    M2m::SalesOrderRelease.filtered.status_open_or_hold.not_filled.includes(:sales_order => :customer).each do |r|
      memos.push [r.id, r.backlog_price, r.due_date.to_date]
      self.total_backlog += r.backlog_price
      if r.due_date < self.date
        late += r.backlog_price
      end
    end
    self.sales_release_memos = memos
    self.total_late_backlog = late
    self.save!
  end

  serialized_attribute :sales_release_memos
  serialized_attribute :total_late_backlog, :des => :to_f

  class SalesReleaseSummary
    attr_accessor :release_id, :release, :backlog_price, :due_date
    def initialize(release, backlog_price, due_date, current_date)
      @release = release
      @backlog_price = backlog_price
      @due_date = due_date
      @current_date = current_date
    end
    def late?
      @current_date > @due_date
    end
  end
  def releases
    @releases ||= M2m::SalesOrderRelease.with_ids(self.sales_release_memos.map(&:first)).includes(:sales_order => :customer)
  end
  def sales_release_summaries
    if @sales_release_summaries.nil?
      releasemap = {}
      self.releases.each do |r|
        releasemap[r.id] = r
      end
      @sales_release_summaries = self.sales_release_memos.map do |sales_release_id, backlog_price, due_date|
        SalesReleaseSummary.new releasemap[sales_release_id], backlog_price.to_f, DateParser.parse(due_date), self.date
      end.sort_by(&:due_date)
    end
    @sales_release_summaries
  end

  class BacklogBucket
    attr_accessor :key, :month, :summaries
    def initialize(month_or_key, current_date)
      if month_or_key.is_a?(Symbol)
        @key = month_or_key
      else
        @key = :month
        @month = month_or_key
      end
      @current_date = current_date
      @current_month = @current_date.beginning_of_month
      @summaries = []
    end
    def add_summary(s)
      @summaries.push s
    end
    def total_future
      if @total_future.nil?
        self.calculate_totals
      end
      @total_future
    end
    def total_late
      if @total_late.nil?
        self.calculate_totals
      end
      @total_late
    end
    def total_backlog
      self.total_future + self.total_late
    end
    def in_current_month?
      if @in_current_month.nil?
        @in_current_month = (self.month == @current_month)
      end
      @in_current_month
    end
    def future?
      (@key == :future) || (@key == :month) && (self.month > @current_date)
    end
    def past?
      (@key == :late) || (@key == :month) && (self.month < self.current_month)
    end
    protected
      def calculate_totals
        @total_future = 0.0
        @total_late = 0.0
        @summaries.each do |s|
          if s.late?
            @total_late += s.backlog_price
          else
            @total_future += s.backlog_price
          end
        end
      end
  end
  def buckets
    if @backlog_buckets.nil?
      buckets = {}
      date = self.date.beginning_of_month
      end_date = self.date.advance(:months => 12)
      while date <= end_date
        buckets[date] = BacklogBucket.new(date, self.date)
        date = date.advance(:months => 1)
      end
      self.sales_release_summaries.each do |s|
        if b = buckets[s.due_date.beginning_of_month]
          b.add_summary s
        else
          if s.due_date < self.date
            self.late_bucket.add_summary s
          else
            self.future_bucket.add_summary s
          end
        end
      end
      sorted_buckets = buckets.values.sort_by(&:month)
      trailing_zero_buckets = sorted_buckets.reverse.index { |bb| bb.total_backlog > 0 }
      # Chop off trailing buckets with 0 backlog.
      @backlog_buckets = sorted_buckets[0..(sorted_buckets.size - trailing_zero_buckets - 1)]
    end
    @backlog_buckets
  end
  def late_bucket
    @late_bucket ||= BacklogBucket.new(:late, self.date)
  end
  def future_bucket
    @future_bucket ||= BacklogBucket.new(:future, self.date)
  end
  
  def xls_filename
    Time.now.strftime("%y%m%d") + '_' + AppConfig.short_name + '_Backlog'
  end
  
  def xls_sheet_name
    'Backlog'
  end
  
  def xls_initialize
    dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
    xls_field('Due Date') { |r| r.due_date }
    xls_field('Customer') { |r| r.release.try(:sales_order).try(:customer).try(:company_name) }
    xls_field('Sales Order') { |r| r.release.try(:sales_order).try(:order_number) }
    xls_field('Part Number') { |r| r.release.try(:item).try(:part_number_and_revision) }
    xls_field('Amount', dollar_format) { |r| r.backlog_price.to_f.round(2) }
  end  
  
  def all_data
    self.sales_release_summaries
  end

end
