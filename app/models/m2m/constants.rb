class M2m::Constants
  @@null_date = Date.parse('1900-01-01')
  cattr_accessor :null_date
  
  def self.sanitize_date(date)
    date == M2m::Constants.null_date ? nil : date
  end
end
    