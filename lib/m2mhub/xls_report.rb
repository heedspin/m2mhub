require 'spreadsheet'

module M2mhub::XlsReport
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
      @fields = []
      self.initialize_fields
    end
    @fields
  end
  
  def all_data
    if @invoice_items.nil?
      raise ':start_date required' unless self.start_date
      raise ':end_date required' unless self.end_date
      raise ':customer required' unless self.customer
      @invoice_items = M2m::InvoiceItem.invoice_dates(self.start_date, self.end_date).not_void.scoped(:include => :invoice)
      @invoice_items = @invoice_items.customer(self.customer) if self.customer.is_a?(M2m::Customer)
      M2m::Item.attach_items(@invoice_items)
      M2m::SalesOrder.attach_sales_orders(@invoice_items)
    end
    @invoice_items
  end

  def to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = self.sheet_name
    column_formats = get_column_formats(self.fields, sheet)
    self.all_data.each do |data_object|
      sheet_row = sheet.row(sheet.last_row_index+1)
      row_data = self.fields.map { |field| 
        field.value_for(data_object) 
      }
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

    # DEC to OCT to HEX Mapping:
    # 128.chr => \200 => \x80
    # 153.chr => \231 => \x99
    # 156.chr => \234 => \x9c
    # 157.chr => \235 => \x9d
    # 162.chr => \242 => \xA2
    # 194.chr => \302 => \xC2
    # 195.chr => \303 => \xC3  ==> bang
    # 226.chr => \342 => \xE2
    EVIL_CHARACTERS = [153, 160, 162, 194, 195, 226]
    def clean_value(txt)
      return txt unless txt.is_a?(String)

      # Evil curly quote replace
      txt = txt.gsub("\xE2\x80\x9c", '"')
      txt = txt.gsub("\xE2\x80\x9d", '"')

      # Get rid of evil A characters:
      # <"Miguel&#39;s"> expected but was
      # <"MiguelÂ&#39;s">.
      EVIL_CHARACTERS.each { |evilc| txt = txt.delete evilc.chr }

      # Replace evil quotes with regular quotes.
      txt = txt.tr "\x91-\x94\x9c\x9d\x80", "''\"\"\"\"'"

      # Entity encode quotes.
      # txt = txt.gsub("'", '&#39;')
      # txt = txt.gsub('"', '&#34;')
      txt.strip
    end
end
