class Quality::ReportSearch
  attr_accessor :year
  attr_accessor :end_date
  def initialize(params)
    params ||= {}
    @year = params['year']
    @end_date = params['end_date']
  end
  def start_date
    Date.new(self.year.to_i, 1, 1)
  end
  def end_date
    Date.parse(@end_date)
  end

  def self.year_options
    Date.current.year.downto(AppConfig.epoch_year || 2000).map(&:to_s)
  end
end

