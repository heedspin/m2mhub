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
    def initialize(months)
      @has_opportunities = false
      @opportunity_buckets = {}
      months.each do |month|
        @opportunity_buckets[month] = OpportunityBucket.new(month)
      end
    end
    def opportunity_buckets
      @opportunity_buckets.values.sort_by(&:date)
    end
    def add_opportunity(date, opportunity)
      @has_opportunities = true
      @opportunity_buckets[date.beginning_of_month].add_opportunity(opportunity)
    end
    def has_opportunities?
      @has_opportunities
    end
  end

  class TerritoryReport < BaseReport
    attr_accessor :territory, :name
    def initialize(territory, months)
      @territory = territory
      @name = territory.sales_rep_name.present? ? territory.sales_rep_name : territory.name
      super(months)
    end
  end

  class OwnerReport < BaseReport
    attr_accessor :owner, :name
    def initialize(owner, months)
      @owner = owner
      @name = owner.full_name
      super(months)
    end
  end
  
  class CollectorReport < BaseReport
    attr_accessor :opportunities
    def initialize(months)
      @opportunities = []
      super(months)
    end
    def add_opportunity(date, opportunity)
      @opportunities.push(opportunity)
      super(date, opportunity)
    end
  end

  attr_accessor :months, :month_report, :homeless_report, :ownerless_report

  def initialize(args=nil)
    args ||= {}
    @end_month = args[:end_month] ||= Date.current.beginning_of_month
    @end_month = Date.parse(@end_month) if @end_month.is_a?(String)
    @start_month = args[:end_date] || @end_month.advance(:months => -12)
    @start_month = Date.parse(@start_month) if @start_month.is_a?(String)
    @territory_reports = {}
    @owner_reports = {}
    @months = []
  end

  def run
    opportunities = Set.new
    quotes = Sales::Quote.date_between(@start_month, @end_month.advance(:months => 1)).includes(:opportunities => {:sales_customer => :sales_territory}).order('sales_quotes.date').all
    
    if month = quotes.first.try(:date).try(:beginning_of_month)
      while month <= @end_month
        @months.push month
        month = month.advance(:months => 1)
      end
    end
    @month_report = BaseReport.new(@months)
    @homeless_report = CollectorReport.new(@months)
    @ownerless_report = CollectorReport.new(@months)
    
    quotes.each do |quote|
      opportunity = quote.opportunity
      next if opportunities.member?(opportunity.id)
      opportunities.add(opportunity.id)
      quote_month = quote.date.beginning_of_month
      @month_report.add_opportunity(quote_month, opportunity)
      if territory = opportunity.sales_customer.try(:sales_territory)
        (@territory_reports[territory.id] ||= TerritoryReport.new(territory, @months)).add_opportunity(quote.date, opportunity)
      else
        @homeless_report.add_opportunity(quote.date, opportunity)
      end
      if opportunity.owner
        (@owner_reports[opportunity.owner.id] ||= OwnerReport.new(opportunity.owner, @months)).add_opportunity(quote.date, opportunity)
      else
        @ownerless_report.add_opportunity(quote.date, opportunity)
      end
    end
    true
  end
  
  def territory_reports
    @territory_reports.values.sort_by(&:name)
  end

  def owner_reports
    @owner_reports.values.sort_by(&:name)
  end
end
