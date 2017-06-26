class DateParser
  def self.parse(val)
    begin
      val.is_a?(String) ? Date.parse(val) : val
    rescue ArgumentError
      begin
        Date.strptime(val, '%m/%d/%Y') 
      rescue ArgumentError
        raise "#{val} is an invalid date"
      end
    end
  end
end