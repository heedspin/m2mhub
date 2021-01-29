class M2m::Constants
  @@null_date = DateParser.parse('Mon, 01 Jan 1900 00:00:00 UTC +00:00')
  cattr_accessor :null_date
  @@null_time = Time.parse('Mon, 01 Jan 1900 00:00:00 UTC +00:00')
  cattr_accessor :null_time
  
  def self.sanitize_date(date)
    date == M2m::Constants.null_date ? nil : date
  end
end
    