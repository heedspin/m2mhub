require File.expand_path('../../config/boot',  __FILE__)
require RAILS_ROOT + '/config/environment'
require 'csv'

M2m::Item.new

class M2m::Item
  def self.lineage?(part_number)
    part_number[0..2] == '408'
  end
  def lineage?
    self.class.lineage?(self.part_number)
  end
end

class BomFlattenCsv
  def initialize
    @row_sep = "\r"
    @input_csv = File.join('/home/tim/Dropbox/temp/cleaned_catalog_orders.csv')
    @exploded_output_csv = File.join('/home/tim/Dropbox/temp/exploded_catalog_orders.csv')
    @summarized_output_csv = File.join('/home/tim/Dropbox/temp/exploded_summary.csv')
    @summary_headers = [ 'PartNo', 'Rev', 'TotalShipQty' ]
  end

  def run
    if !File.exists?(@input_csv)
      puts "File not found: #{@input_csv}"
      1
    else
      parse_csv
      write_summary
    end
  end
  
  def write_summary
    @current_headers = @summary_headers
    File.open(@summarized_output_csv, 'w+') do |output|
      @current_output = output
      output.puts @summary_headers.join(',')
      @summaries.values.sort_by { |s| s['TotalShipQty'] }.reverse.each do |s|
        write_row(s)
      end
    end
    0
  end

  def parse_csv
    @first_row = nil
    @summaries = {}
    # @count = 0
    File.open(@exploded_output_csv, 'w+') do |exploded_output|
      @current_output = exploded_output
      CSV.open(@input_csv, 'r', nil, @row_sep) do |row|
        if @first_row.nil?
          @current_headers = @first_row = row
          exploded_output.puts @first_row.join(',')
        else
          row_hash = {}
          @first_row.each_with_index do |column_name, index|
            row_hash[column_name]=row[index]
          end
          parse_row(row_hash)
          # @count += 1
          # if @count > 10
          #   return 0
          # end
        end
      end
    end
    0
  end

  def parse_row(row_hash)
    part_number = row_hash['PartNo']
    revision = row_hash['Rev']
    ship_quantity = row_hash['ShipQty']
    if M2m::Item.lineage?(part_number) and (row_hash['CustNo'].to_i == 457)
      result = get_bom_items(part_number, revision)
      if result.is_a?(String)
        # Translated to generic kit.
        row_hash['PartNo'] = result
        write_row(row_hash)
        summarize(row_hash)
      else
        # Write each bom item
        result.each do |bom_item|
          next if filter_part?(bom_item.part_number)
          bom_hash = row_hash.clone
          bom_hash['PartNo'] = bom_item.part_number
          bom_hash['Rev'] = bom_item.revision
          bom_hash['ShipQty'] = ship_quantity.to_i * bom_item.quantity
          bom_hash['Descript'] = bom_item.item.description
          bom_hash['UnitPrice'] = ''
          bom_hash['RollMatlCost'] = bom_item.item.rolled_material_cost
          bom_hash['RollLabCost'] = bom_item.item.rolled_labor_cost
          write_row(bom_hash)
          summarize(bom_hash)
        end
      end
    else
      unless filter_part?(row_hash['PartNo'])
        write_row(row_hash)
        summarize(row_hash)
      end
    end
  end
  
  def filter_part?(part_number)
    part_number = part_number.downcase
    %w(hn lw fw hhc etlw cb).any? { |fs| part_number[0..(fs.size-1)] == fs }
  end
  
  def summarize(row_hash)
    part_number = row_hash['PartNo']
    revision = row_hash['Rev']
    ship_quantity = row_hash['ShipQty'].to_i
    key = [part_number, revision]
    summary = @summaries[key] ||= { 'PartNo' => part_number, 'Rev' => revision, 'TotalShipQty' => 0 }
    summary['TotalShipQty'] += ship_quantity
  end
  
  def write_row(row_hash)
    @current_output.puts @current_headers.map { |h| "\"#{row_hash[h]}\"" }.join(',')
  end
  
  def get_bom_items(part_number, revision)
    @cache ||= {}
    key = [part_number, revision]
    if found = @cache[key]
      found
    else
      # Explode
      bom_items = M2m::BomItem.for_parent_item(part_number, revision).all      
      puts "Exploded #{part_number} into " + bom_items.map(&:part_number).map(&:strip).join(', ')

      # Find if all the bom items have a common parent
      common = nil
      bom_items.each do |bom_item|
        parent_part_numbers = bom_item.item.bom_items.map(&:parent_part_number).map(&:strip).select { |pn| !M2m::Item.lineage?(pn) }
        if common.nil?
          common = parent_part_numbers
        else
          common &= parent_part_numbers
        end
      end
      # Implode
      if common.present? and (common.size > 0)
        # Let's be lazy and assume it's a match.
        @cache[key] = generic_kit = common.first
        puts "Found generic kit #{generic_kit} for lineage #{part_number}"
        generic_kit
      else
        @cache[key] = bom_items
      end
    end
  end
end

exit BomFlattenCsv.new.run
