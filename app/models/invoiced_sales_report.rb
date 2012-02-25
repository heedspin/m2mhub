require 'spreadsheet'

class InvoicedSalesReport
  attr_accessor :start_date, :end_date, :customer
  
  def initialize(args)
    args ||= {}
    self.customer = args[:customer]
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
  end
  
  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end
  
  def filename
    # Time.now.strftime("%y%m%d") + '_' + 
    customer_name = self.customer.is_a?(M2m::Customer) ? self.customer.name : CompanyConfig.name
    name = "#{self.start_date.year} #{customer_name} Invoiced Sales"
    name.gsub(' ', '_').gsub(',','')
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
      @fields.push Field.new("#{CompanyConfig.name} Part Number") { |invoice_item| invoice_item.part_number }
      @fields.push Field.new('Part Description') { |invoice_item| invoice_item.item.try(:description) }
      @fields.push Field.new('Customer Part Number') { |invoice_item| clean_value invoice_item.customer_part_number }
      @fields.push Field.new('Quantity') { |invoice_item| invoice_item.ship_quantity }
      @fields.push Field.new('Unit Price', dollar_format) { |invoice_item| 
        invoice_item.unit_price.to_f.round(2)
      }
      @fields.push Field.new('Invoice Amount', dollar_format) { |invoice_item| 
        invoice_item.amount.to_f.round(2) 
      }
      if self.customer == :all
        @fields.push Field.new('Customer Number') { |invoice_item| invoice_item.invoice.customer_number }
        @fields.push Field.new('Customer Name') { |invoice_item| invoice_item.invoice.customer_name }
        @fields.push Field.new('Group') { |invoice_item| invoice_item.item.try(:fgroup).try(:strip) }        
        @fields.push Field.new('Invoice Description') { |invoice_item| invoice_item.description }
      end
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
    sheet.name = 'Invoiced Sales'
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
