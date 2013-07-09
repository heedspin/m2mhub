# == Schema Information
#
# Table name: sales_reports
#
#  id                    :integer          not null, primary key
#  report_time_period_id :integer
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
  self.table_name = 'sales_reports'
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
    month = Date.parse(month) if month.is_a?(String)
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
    
    # Adding the not_adjustments filter removes entries that may be LXD specific. If so I will need to refactor this out of the core.
    revenue_journal_entries = M2m::GlTransaction.post_dates(self.date, next_month).journal_entries.gl_category('R').not_balance_entries.not_adjustments.all(:include => :gl_account)
    revenue_journal_entries = revenue_journal_entries.select { |je| self.class.is_revenue_account?(je.post_date, je.gl_account_number) }
    self.gl_transaction_ids = revenue_journal_entries.map(&:id)

    ar_distributions = M2m::ArDistribution.dates(self.date, next_month).non_zero.gl_category('R').all(:include => :gl_account)
    ar_distributions = ar_distributions.select { |ar| self.class.is_revenue_account?(ar.date, ar.gl_account_number) }
    self.ar_distribution_ids = ar_distributions.map(&:id)
    # puts ar_distributions.map { |ar| [ar.date.to_s(:database), ar.gl_account_number, ar.amount, ar.status].join(', ') }.join("\n")

    self.invoiced_sales = ar_distributions.sum(&:value) + revenue_journal_entries.sum(&:value)

    revenue_journal_entries = M2m::GlTransaction.post_dates(beginning_of_year, next_month).journal_entries.gl_category('R').not_balance_entries.not_adjustments.all(:include => :gl_account)
    revenue_journal_entries = revenue_journal_entries.select { |je| self.class.is_revenue_account?(je.post_date, je.gl_account_number) }

    ar_distributions = M2m::ArDistribution.dates(beginning_of_year, next_month).non_zero.gl_category('R').all(:include => :gl_account)
    ar_distributions = ar_distributions.select { |ar| self.class.is_revenue_account?(ar.date, ar.gl_account_number) }

    self.ytd_invoiced_sales = ar_distributions.sum(&:value) + revenue_journal_entries.sum(&:value)

    if AppConfig.enable_opportunities?
      self.new_opportunities = Sales::Opportunity.start_dates(self.date, next_month).sum(:amount)
    end

    self.save!
  end

  class << self
    def is_revenue_account?(on_date, gl_account_number)
      !not_revenue_accounts(on_date).include?(gl_account_number.strip)
    end
    def not_revenue_accounts(on_date)
      return [] unless AppConfig.sales_report_not_revenue_accounts
      on_date = Date.parse(on_date) if on_date.is_a?(String)
      @not_revenue_accounts ||= {}
      if @not_revenue_accounts.member?(on_date)
        r = @not_revenue_accounts[on_date]
        # puts "#{on_date.to_s(:database)}: not_revenue_accounts(#{r.join(',')})"
        r
      else
        result = []
        AppConfig.sales_report_not_revenue_accounts.each do |account_number, config|
          config ||= {}
          start_date = config['start_date']
          start_date = Date.parse(start_date) if start_date.is_a?(String)
          end_date = config['end_date']
          end_date = Date.parse(end_date) if end_date.is_a?(String)
          if (start_date.nil? or (on_date >= start_date)) and (end_date.nil? or (on_date <= end_date))
            result.push account_number.to_s
          end
        end
        @not_revenue_accounts[on_date] = result
        # puts "#{on_date.to_s(:database)}: not_revenue_accounts(#{result.join(',')})"
        result
      end
    end
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
