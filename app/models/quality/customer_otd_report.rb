class Quality::CustomerOtdReport
  class VendorLates
    attr_accessor :name, :num_releases, :late_releases
    def initialize(name)
      @name = name
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
  class Month
    attr_accessor :date, :num_releases, :late_releases
    def initialize(date)
      @date = date
      @num_releases = 0
      @late_releases = []
      @vendor_lates = {}
    end
    def add_late_release(release)
      @late_releases.push release
      if vendor_name = release.item.vendors.first.try(:vendor).try(:name)
        (@vendor_lates[vendor_name] ||= VendorLates.new(vendor_name)).add_late_release(release)
      end
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
    def vendor_lates
      @vendor_lates.values.sort_by(&:name)
    end
  end

  def initialize(args=nil)
    args ||= {}
    @start_date = args[:start_date] ||= Date.current.beginning_of_year    
    @end_date = args[:end_date] || @start_date.advance(:years => 1)
    if @end_date > Date.current
      @end_date = Date.current.advance(:days => 1)
    end
    @months = {}
    @vendor_lates = {}
  end
  
  def run
    # Get total releases by date.
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
    # Get total release by vendor
    results = M2m::SalesOrderRelease.connection.select_rows <<-SQL
    select apvend.fcompany, count(*) as total
    from (
    select sorels.identity_column, max(invend.identity_column) as invendid
    from invend
    left join sorels on sorels.fpartno = invend.fpartno and sorels.fpartrev = invend.fpartrev
    where sorels.fduedate >= '#{@start_date.to_s(:db)}'
      and sorels.fduedate < '#{@end_date.to_s(:db)}'
    group by sorels.identity_column
    ) subquery
    left join invend on invend.identity_column = subquery.invendid
    left join apvend on invend.fvendno = apvend.fvendno
    group by apvend.fcompany
    SQL
    results.each do |result_row|
      vendor_name, count = result_row
      self.get_vendor_late(vendor_name).num_releases += count
    end

    late_releases = M2m::SalesOrderRelease.shipped_late.due(@start_date, @end_date)
    M2m::SalesOrderItem.attach_to_releases(late_releases)
    late_releases.each do |release|
      if vendor_name = release.item.try(:vendors).try(:first).try(:vendor).try(:name)
        month_for(release.due_date).add_late_release(release)
        self.get_vendor_late(vendor_name).add_late_release(release)
      end
    end
    true
  end

  def get_vendor_late(vendor_name)
    vendor_name = vendor_name.try(:strip).try(:titleize) || 'No Company'
    @vendor_lates[vendor_name] ||= VendorLates.new(vendor_name)
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

  def vendor_lates
    @vendor_lates.values.select { |vl| vl.num_late_releases > 0 }.sort_by(&:name)
  end
  
end
