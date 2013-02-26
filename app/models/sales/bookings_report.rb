# == Schema Information
#
# Table name: bookings_reports
#
#  id                    :integer          not null, primary key
#  report_time_period_id :integer
#  date                  :date
#  data                  :text
#  bookings              :decimal(12, 2)
#  ytd_bookings          :decimal(12, 2)
#  created_at            :datetime
#  updated_at            :datetime
#

require 'plutolib/serialized_attributes'

class Sales::BookingsReport < M2mhub::Base
  include Plutolib::SerializedAttributes
  set_table_name 'bookings_reports'
  belongs_to_active_hash :report_time_period
  scope :date, lambda { |date|
    {
      :conditions => { :date => date }
    }
  }
  scope :dates, lambda { |start_date, end_date|
    {
      :conditions => [ 'bookings_reports.date >= ? and bookings_reports.date < ?', start_date, end_date]
    }
  }
  scope :time_period, lambda { |report_time_period|
    {
      :conditions => { :report_time_period_id => report_time_period.id }
    }
  }
  scope :by_date_desc, :order => 'bookings_reports.date desc'
  scope :month, lambda { |month|
    {
      :conditions => { :date => month.beginning_of_month, :report_time_period_id => ReportTimePeriod.month.id }
    }
  }

  # Bookings
  # M2m::SalesOrderRelease.order_dates('2012-06-01', '2012-07-01').sum(:fnetprice).to_f
  def run!
    next_month = self.date.advance(:months => 1)
    releases = M2m::SalesOrderRelease.master_or_single.order_dates(self.date, next_month).status_not_cancelled.all(:include => :sales_order)
    self.bookings = releases.sum(&:total_price)
    self.ytd_bookings = M2m::SalesOrderRelease.master_or_single.order_dates(self.date.beginning_of_year, next_month).status_not_cancelled.sum(:fnetprice)
    
    sales_orders = {}
    releases.each do |r|
      if x = sales_orders[r.sales_order_number]
        x[1] = x[1] + r.total_price
      else
        sales_orders[r.sales_order_number] = [r.sales_order_number, r.total_price]
      end
    end
    self.sales_order_memos = sales_orders.values
    self.save!
  end
  
  serialized_attribute :sales_order_memos

  SalesOrderSummary = Struct.new(:sales_order, :total_price)
  def sales_order_summaries
    if @sales_order_summaries.nil?
      sales_orders = {}
      M2m::SalesOrder.with_order_numbers(self.sales_order_memos.map(&:first)).all(:include => :customer).each do |so|
        sales_orders[so.order_number] = so
      end
      @sales_order_summaries = self.sales_order_memos.map do |sales_order_number, total_price|
        SalesOrderSummary.new sales_orders[sales_order_number], total_price
      end
    end
    @sales_order_summaries
  end
end
