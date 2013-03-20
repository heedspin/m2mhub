class Sales::OpportunityReport

  class OpportunityBucket
    attr_accessor :date, :total_quoted_opportunities, :total_value
    def initialize(date)
      @date = date
      @total_quoted_opportunities = 0
      @total_value = 0
    end
    def add_opportunity(opportunity)
      @total_quoted_opportunities += 1
      @total_value += (opportunity.amount || 0)
    end
  end

  class BaseReport
    attr_accessor :name
    def initialize(name, time_periods)
      @name = name
      @has_opportunities = false
      @opportunity_buckets = {}
      time_periods.each do |date|
        @opportunity_buckets[date] = OpportunityBucket.new(date)
      end
    end
    def opportunity_buckets
      @opportunity_buckets.values.sort_by(&:date)
    end
    def add_opportunity(date, opportunity)
      @has_opportunities = true
      @opportunity_buckets[date].add_opportunity(opportunity)
    end
    def has_opportunities?
      @has_opportunities
    end
  end

  class CollectorReport < BaseReport
    attr_accessor :opportunities
    def initialize(name, time_periods)
      @opportunities = []
      super(name, time_periods)
    end
    def add_opportunity(date, opportunity)
      @opportunities.push(opportunity)
      super(date, opportunity)
    end
  end

  class TimePeriodReport
    attr_accessor :total_report, :territory_reports, :owner_reports, :time_periods, :homeless_report, :ownerless_report, :period
    def initialize(start_date, end_date, period, earliest_date)
      @start_date = start_date
      @end_date = end_date
      @period = period
      @time_periods = []
      date = earliest_date.send("beginning_of_#{@period}")
      date = @start_date if date < @start_date
      advance_key = period.to_s.pluralize.to_sym
      while date <= @end_date
        @time_periods.push date
        date = date.advance(advance_key => 1)
      end
      @territory_reports = {}
      @owner_reports = {}
      @total_report = BaseReport.new('Total', @time_periods)
      @homeless_report = CollectorReport.new('Homeless', @time_periods)
      @ownerless_report = CollectorReport.new('Ownerless', @time_periods)
    end
    
    def add_opportunity(quote_date, opportunity, territory, owner)
      date = quote_date.send("beginning_of_#{@period}")
      @total_report.add_opportunity(date, opportunity)
      if territory
        (@territory_reports[territory.id] ||= BaseReport.new(territory.sales_rep_name.present? ? territory.sales_rep_name : territory.name, @time_periods)).add_opportunity(date, opportunity)
      else
        @homeless_report.add_opportunity(date, opportunity)
      end
      if owner
        (@owner_reports[opportunity.owner.id] ||= BaseReport.new(opportunity.owner.full_name, @time_periods)).add_opportunity(date, opportunity)
      else
        @ownerless_report.add_opportunity(date, opportunity)
      end
    end
    
    def territory_reports
      @territory_reports.values.sort_by(&:name)
    end

    def owner_reports
      @owner_reports.values.sort_by(&:name)
    end
  end

  attr_accessor :time_periods, :total_report, :homeless_report, :ownerless_report, :week_report, :month_report, :year_report
  
  def initialize
    @start_date = Date.current.beginning_of_year
    @end_date = Date.current
    @end_week = Date.current.beginning_of_week
    @start_week = @end_week.advance(:weeks => -4)
    @start_month = Date.current.beginning_of_year
    @end_month = Date.current.beginning_of_month
    @start_year = Date.current.beginning_of_year
    @end_year = Date.current.beginning_of_year
  end

  def run
    opportunities = Set.new
    quotes = Sales::Quote.date_between(@start_date, @end_date).includes(:opportunities => {:sales_customer => :sales_territory}).order('sales_quotes.date').all

    earliest_date = quotes.first.date
    @week_report = TimePeriodReport.new(@start_week, @end_week, :week, earliest_date)
    @month_report = TimePeriodReport.new(@start_month, @end_month, :month, earliest_date)
    @year_report = TimePeriodReport.new(@start_year, @end_year, :year, earliest_date)
    
    quotes.each do |quote|
      opportunity = quote.opportunity
      next if opportunities.member?(opportunity.id)
      opportunities.add(opportunity.id)
      quote_date = quote.date
      territory = opportunity.sales_customer.try(:sales_territory)
      owner = opportunity.owner
      @week_report.add_opportunity(quote_date, opportunity, territory, owner)
      @month_report.add_opportunity(quote_date, opportunity, territory, owner)
      @year_report.add_opportunity(quote_date, opportunity, territory, owner)
    end
    true
  end
end
