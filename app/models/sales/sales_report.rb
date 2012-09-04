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
#  created_at            :datetime
#  updated_at            :datetime
#

require 'plutolib/serialized_attributes'

class Sales::SalesReport < M2mhub::Base
  include Plutolib::SerializedAttributes
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
  # M2m::GlTransaction.post_dates('2012-05-01', '2012-06-01').gl_category('R').not_receivables_or_credits.all(:include => :gl_account).sum(&:value).to_f
  def run!
    next_month = self.date.advance(:months => 1)
    beginning_of_year = self.date.beginning_of_year

    revenue_journal_entries = M2m::GlTransaction.post_dates(self.date, next_month).journal_entries.gl_category('R').not_balance_entries.all(:include => :gl_account)
    self.gl_transaction_ids = revenue_journal_entries.map(&:id)
    ar_distributions = M2m::ArDistribution.dates(self.date, next_month).non_zero.gl_category('R').not_receivables_or_credits.all(:include => :gl_account)
    self.ar_distribution_ids = ar_distributions.map(&:id)

    self.invoiced_sales = ar_distributions.sum(&:value) + revenue_journal_entries.sum(&:value)
    # self.net_invoiced_sales = M2m::ArDistribution.dates(self.date, next_month).non_zero.not_cash.receivables_and_credits.sum(:fnamount) + revenue_journal_entries.sum(&:value)

    jsum = M2m::GlTransaction.post_dates(beginning_of_year, next_month).journal_entries.gl_category('R').not_balance_entries.all(:include => :gl_account).sum(&:value)
    ar_distributions = M2m::ArDistribution.dates(beginning_of_year, next_month).non_zero.gl_category('R').not_receivables_or_credits.all(:include => :gl_account)

    self.ytd_invoiced_sales = ar_distributions.sum(&:value) + jsum
    # self.ytd_net_invoiced_sales = ar.receivables_and_credits.sum(:fnamount) + revenue_journal_entries
    
    self.new_opportunities = Sales::Opportunity.start_dates(self.date, next_month).sum(:amount)
    # self.ytd_new_opportunities = Sales::Opportunity.start_dates(beginning_of_year, next_month).sum(:amount)

    self.save!
  end
  
  # To use after adding new stat.
  def upgrade!
    next_month = self.date.advance(:months => 1)
    beginning_of_year = self.date.beginning_of_year
    self.new_opportunities = Sales::Opportunity.start_dates(self.date, next_month).sum(:amount)
    self.save!
  end

  serialized_attribute :ytd_invoiced_sales, :des => :to_f
  serialized_attribute :ytd_net_invoiced_sales, :des => :to_f
  serialized_attribute :ytd_bookings, :des => :to_f
  serialized_attribute :ar_distribution_ids
  serialized_attribute :gl_transaction_ids
  serialized_attribute :new_opportunities, :des => :to_i
  serialized_attribute :ytd_new_opportunities, :des => :to_i
  
  def ar_distributions
    @ar_distributions ||= M2m::ArDistribution.ids(self.ar_distribution_ids).all(:include => :gl_account)
  end
  def gl_transactions
    @gl_transactions ||= M2m::GlTransaction.ids(self.gl_transaction_ids).all(:include => :gl_account)
  end
end
