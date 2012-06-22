class Quality::CustomerOtdReport
  class Month
    attr_accessor :date, :num_releases, :late_releases
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
    def percent_late
      if (self.num_releases <= 0) or (self.num_releases < self.num_late_releases)
        100
      else
        (self.num_late_releases.to_f / self.num_releases) * 100
      end
    end
  end

  def initialize(args=nil)
    args ||= {}
    @start_date = args[:start_date] ||= Date.current.beginning_of_year    
    @end_date = args[:end_date] || @start_date.advance(:years => 1)
    @months = {}
  end
  
  def run
    results = M2m::SalesOrderRelease.connection.select_rows <<-SQL
    select sorels.fduedate, count(*) 
    from sorels
    where sorels.fduedate >= '#{@start_date.to_s(:db)}'
      and sorels.fduedate < '#{@end_date.to_s(:db)}'
    group by sorels.fduedate
    order by sorels.fduedate
    SQL
    results.each do |result_row|
      due_date, count = result_row
      month_for(due_date).num_releases += count
    end
    late_releases = M2m::SalesOrderRelease.shipped_late.due(@start_date, @end_date)
    M2m::SalesOrderItem.attach_to_releases(late_releases)
    late_releases.each do |late_release|
      month_for(late_release.due_date).add_late_release(late_release)
    end
    true
  end

  def ordered_months
    @months.values.sort_by(&:date)
  end
  
  def month_for(date)
    month_date = Date.new(date.year, date.month, 1)
    @months[month_date] ||= Month.new(month_date)
  end
  
  def all_late_releases
    @months.values.map(&:late_releases).flatten
  end
  
  def num_releases
    @num_releases ||= @months.values.sum(&:num_releases)
  end
  
  def num_late_releases
    @num_late_releases ||= @months.values.sum(&:num_late_releases)
  end

  def percent_late
    if (self.num_releases <= 0) or (self.num_releases < self.num_late_releases)
      100
    else
      (self.num_late_releases.to_f / self.num_releases) * 100
    end
  end
  
end
