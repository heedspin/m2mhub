class DateParser
  def self.parse(val)
    begin
      val.is_a?(String) ? Date.parse(val) : val
    rescue ArgumentError
      begin
        result = Date.strptime(val, '%m/%d/%Y') 
        if result.year < 1000
          result = Date.new(2000 + result.year, result.month, result.day)
        end
        result
      rescue ArgumentError
        raise "#{val} is an invalid date"
      end
    end
  end
end