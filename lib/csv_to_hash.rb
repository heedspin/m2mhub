require 'xls_to_hash'
require 'csv'
class CsvToHash
  def self.parse_file(path, &block)
    header = nil
    CSV.open(path, 'r') do |row|
      if header.nil?
        header = row
      else
        row_hash = {}
        row.each_with_index do |value, index|
          value = XlsToHash.clean_value(value)
          row_hash[header[index]] = value unless value.nil?
        end
        yield(row_hash)
      end
    end
  end
end