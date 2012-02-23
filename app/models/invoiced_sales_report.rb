require 'spreadsheet'

class InvoicedSalesReport
  def initialize(args)
    return unless args
    @customer = args[:customer] || (raise ':customer required')
    @start_date = Date.parse args[:start_date] || (raise ':start_date required')
    @end_date = Date.parse args[:end_date] || (raise ':end_date required')
    @name = "#{@start_date.year} #{@customer.name} Invoiced Sales"
  end

  def filename
    # Time.now.strftime("%y%m%d") + '_' + 
    @name.gsub(' ', '_').gsub(',','')
  end
  
  class Field
    attr_reader :column_header, :number_format
    def initialize(column_header, number_format=nil, &value_block)
      @number_format = number_format
      @column_header = column_header
      @value_block = value_block
    end
    def value_for(data_object)
      @value_block.call(data_object)
    end
  end
  
  def fields
    if @fields.nil?
      dollar_format = Spreadsheet::Format.new(:number_format => '$#,##0.00')
      @fields = []
      @fields.push Field.new('Invoice Date') { |invoice_item| invoice_item.invoice.date }
      @fields.push Field.new('Invoice Number') { |invoice_item| invoice_item.invoice_number }
      @fields.push Field.new('Sales Order Number') { |invoice_item| invoice_item.sales_order_number }
      @fields.push Field.new('LXD Part Number') { |invoice_item| invoice_item.item.try(:part_number) }
      @fields.push Field.new('Description') { |invoice_item| invoice_item.item.try(:description) }
      @fields.push Field.new('Customer Part Number') { |invoice_item| invoice_item.customer_part_number }
      @fields.push Field.new('Quantity') { |invoice_item| invoice_item.ship_quantity }
      @fields.push Field.new('Unit Price', dollar_format) { |invoice_item| 
        invoice_item.unit_price.to_f.round(2)
      }
      @fields.push Field.new('Invoice Amount', dollar_format) { |invoice_item| 
        invoice_item.amount.to_f.round(2) 
      }
    end
    @fields
  end
  
  def all_data
    @invoice_items ||= M2m::InvoiceItem.customer(@customer).invoice_dates(@start_date, @end_date).not_void
  end

  def to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = 'Invoiced Sales'
    column_formats = get_column_formats(self.fields, sheet)
    self.all_data.each do |data_object|
      sheet_row = sheet.row(sheet.last_row_index+1)
      row_data = self.fields.map { |field| 
        field.value_for(data_object) 
      }
      Rails.logger.debug "Row data: " + row_data.join(', ')
      sheet_row.push *row_data
      # Set formats for each cell in the row.
      for x in 0..row_data.size-1
        sheet_row.set_format(x, column_formats[x])
      end
    end

    s = StringIO.new
    book.write(s)
    s.string
  end

  protected

    def get_column_formats(fields, sheet)
      @time_format   ||= Spreadsheet::Format.new(:number_format => 'h:mm:ss AM/PM')
      @text_format   ||= Spreadsheet::Format.new
      @date_format   ||= Spreadsheet::Format.new(:number_format => 'mm/dd/yyyy')
      @header_format ||= Spreadsheet::Format.new :weight => :bold, :size => 12

      default_column_formats = {}
      for x in 0..fields.size-1
        field = fields[x]
        sheet.row(0).push field.column_header
        sheet.row(0).set_format(x, @header_format)
        if field.number_format.present?
          default_column_formats[x] = field.number_format
        else
          case field.column_header
          when /Time/
            sheet.column(x).width = 11
            default_column_formats[x] = @time_format
          when /Date/
            sheet.column(x).width = 11
            default_column_formats[x] = @date_format
          else
            default_column_formats[x] = @text_format
          end
        end
      end
      default_column_formats
    end

end
