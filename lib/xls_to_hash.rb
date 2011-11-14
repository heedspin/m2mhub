class XlsToHash
  def self.parse_file(path, &block)
    book = Spreadsheet.open(path)
    book.worksheets.each do |sheet|
      self.parse_worksheet(sheet, &block)
    end
  end
  
  def self.parse_worksheet(sheet,&block)
    header = sheet.row(0)
    sheet.each(1) do |row|
      row_hash = {}
      row.each_with_index do |value, index|
        value = self.clean_value(value)
        row_hash[header[index]] = value unless value.nil?
      end
      yield(row_hash)
    end
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
  def self.clean_value(txt)
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