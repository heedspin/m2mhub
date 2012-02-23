class ReportDateRange
  attr_accessor :start_date, :end_date
  def initialize(params)
    params ||= {}
    @start_date = params['start_date']
    @end_date = params['end_date']
  end
end

