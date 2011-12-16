class RmaReport
  class Month
    attr_accessor :date, :ship_quantity, :rma_quantity, :rmas
    def initialize(date)
      @date = date
      @ship_quantity = 0
      @rmas = []
    end
    def add_rma(rma)
      @rmas.push(rma)
    end
    def total_rmas
      @rmas.size
    end
  end

  def initialize(args=nil)
    args ||= {}
    @start_date = args[:start_date] ||= Date.current.beginning_of_year    
  end
  
  def run
    M2m::CustomerServiceLog.since(@start_date).each do |rma|
      month_for(rma.date).add_rma(rma)
    end
    true
  end

  def ordered_months
    @months.values.sort_by(&:date)
  end
  
  def month_for(date)
    @months ||= {}
    month_date = Date.new(date.year, date.month, 1)
    @months[month_date] ||= Month.new(month_date)
  end
  
  def all_rmas
    @months.values.map(&:rmas).flatten
  end
end
