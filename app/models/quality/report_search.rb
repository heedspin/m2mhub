class Quality::ReportSearch
  attr_accessor :year
  def initialize(params)
    params ||= {}
    @year = params['year']
  end
  def to_date
    Date.new(self.year.to_i, 1, 1)
  end

  def self.year_options
    Date.current.year.downto(CompanyConfig.epoch_year || 2000).map(&:to_s)
  end
end

