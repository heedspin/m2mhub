class CustomerOtdReport
  class Month
    attr_accessor :date, :num_releases, :releases
    def initialize(date)
      @date = date
      @num_releases = 0
      @late_releases = []
    end
    def add_late_release(release)
      @late_releases.push release
    end
    def num_late_releases
      @late_releases.size
    end
  end

  def run(args={})
    start_date = args[:start_date] ||= Date.current.beginning_of_year    
    results = M2m::SalesOrderRelease.connection.select_rows <<-SQL
    select flshipdate, count(*) 
    from sorels
    where sorels.flshipdate >= '#{start_date.to_s(:db)}'
    group by sorels.flshipdate
    order by sorels.flshipdate
    SQL
    results.each do |result_row|
      ship_date, count = result_row
      month_for(ship_date).num_releases += count
    end
    M2m::SalesOrderRelease.shipped_late.due_after(start_date).each do |late_release|
      month_for(late_release.due_date).add_late_release(late_release)
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
end
