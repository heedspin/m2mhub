class Sales::DateReport
  attr_accessor :date
  attr_accessor :sales_report
  attr_accessor :bookings_report
  
  def initialize(date)
    @date = date
  end
  
  def self.create(args)
    result = {}
    [:sales_reports, :bookings_reports].each do |key|
      if reports = args[key]
        reports.each do |r|
          date_report = result[r.date] ||= new(r.date)
          date_report.send("#{key.to_s.singularize}=", r)
        end
      end
    end
    result.values.sort_by(&:date)
  end
end