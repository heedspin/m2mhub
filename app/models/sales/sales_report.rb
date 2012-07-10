# == Schema Information
#
# Table name: sales_reports
#
#  id                    :integer(4)      not null, primary key
#  report_time_period_id :integer(4)
#  date                  :date
#  data                  :text
#  invoiced_sales        :decimal(12, 2)
#  net_invoiced_sales    :decimal(12, 2)
#  bookings              :decimal(12, 2)
#  created_at            :datetime
#  updated_at            :datetime
#

class Sales::SalesReport < ApplicationModel
  set_table_name 'sales_reports'
  belongs_to_active_hash :report_time_period
  scope :date, lambda { |date|
    {
      :conditions => { :date => date }
    }
  }
  scope :time_period, lambda { |report_time_period|
    {
      :conditions => { :report_time_period_id => report_time_period.id }
    }
  }
  scope :by_date_desc, :order => 'sales_reports.date desc'
  scope :month, lambda { |month|
    {
      :conditions => { :date => month.beginning_of_month, :report_time_period_id => ReportTimePeriod.month.id }
    }
  }

  # Bookings
  # M2m::SalesOrderRelease.order_dates('2012-06-01', '2012-07-01').sum(:fnetprice).to_f
  #
  # Net InvTotal
  # M2m::Invoice.invoice_dates('2012-06-01', '2012-07-01').sum(:fnamount).to_f
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').receivables_and_credits.not_cash.non_zero.sum(:fnamount).to_f
  #
  # Invoiced Sales
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').gl_category('R').not_cash.non_zero.not_receivables_or_credits.sum(:fnamount).to_f * -1
  # M2m::ArDistribution.dates('2012-06-01', '2012-07-01').gl_category('R').not_cash.non_zero.not_receivables_or_credits.all(:include => :gl_account).sum(&:value).to_f
  def run!
    next_month = self.date.advance(:months => 1)
    ar = M2m::ArDistribution.dates(self.date, next_month).not_cash.non_zero
    self.invoiced_sales = ar.gl_category('R').not_receivables_or_credits.all(:include => :gl_account).sum(&:value)
    self.net_invoiced_sales = ar.receivables_and_credits.sum(:fnamount)
    self.bookings = M2m::SalesOrderRelease.order_dates(self.date, next_month).sum(:fnetprice)
    self.save!
  end

  def data
    if @data.nil?
      if x = super
        @data = ActiveSupport::JSON.decode(x)
      else
        @data = Hash.new(0)
      end
    end
    @data
  end

  protected

    before_save :serialize_data
    def serialize_data
      self.data = self.data.to_json
    end
end
