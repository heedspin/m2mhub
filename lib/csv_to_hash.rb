require 'xls_to_hash'
require 'csv'
class CsvToHash
  def self.parse_file(path, options=nil, &block)
    options ||= {}
    header = nil
    CSV.open(path, 'r') do |row|
      if header.nil?
        header = if options[:downcase_keys]
          row.map { |c| c.data.downcase }
        else
          row.map { |c| c.data }
        end
      else
        row_hash = {}
        row.each_with_index do |value, index|
          value = XlsToHash.clean_value(value)
          row_hash[header[index]] = value.try(:data)
        end
        yield(row_hash)
      end
    end
  end
end