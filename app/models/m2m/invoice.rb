# == Schema Information
#
# Table name: armast
#
#  fbcity           :char(20)         default("                    "), not null
#  fbcompany        :varchar(35)      default(""), not null
#  fbcountry        :char(25)         default("                         "), not null
#  fbstate          :char(20)         default("                    "), not null
#  fbzip            :char(10)         default("          "), not null
#  fccity           :char(20)         default("                    "), not null
#  fccompany        :varchar(35)      default(""), not null
#  fccountry        :char(25)         default("                         "), not null
#  fcstate          :char(20)         default("                    "), not null
#  fczip            :char(10)         default("          "), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  fcinvoice        :char(20)         default("                    "), not null, primary key
#  fcsource         :char(1)          default(" "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fctermsid        :char(4)          default("    "), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcustno          :char(6)          default("      "), not null
#  fdfactdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdgldate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffreight         :money            default(0.0), not null
#  ffob             :char(20)         default("                    "), not null
#  finvdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fliscod          :boolean          default(FALSE), not null
#  flishand         :boolean          default(FALSE), not null
#  flisprint        :boolean          default(FALSE), not null
#  flpostnow        :boolean          default(FALSE), not null
#  finvtype         :char(1)          default(" "), not null
#  fnamount         :money            default(0.0), not null
#  fngoodsamt       :money            default(0.0), not null
#  fncredits        :money            default(0.0), not null
#  fncurex          :money            default(0.0), not null
#  fninvdisrt       :decimal(11, 5)   default(0.0), not null
#  fnfinchg         :money            default(0.0), not null
#  fnpaytype        :integer          default(0), not null
#  fntotalwt        :decimal(12, 4)   default(0.0), not null
#  fnumber          :char(25)         default("                         ")
#  fpaidref         :char(20)         default("                    "), not null
#  fpono            :char(20)         default("                    "), not null
#  fretrndate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fsalespn         :char(3)          default("   "), not null
#  fshipdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fshipvia         :char(10)         default("          "), not null
#  fsono            :varchar(10)      default(""), not null
#  ftaxamt          :money            default(0.0), not null
#  ftaxcode         :char(3)          default("   "), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fdvoiddate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flpremcv         :boolean          default(FALSE), not null
#  fdtaxpoint       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null
#  fmbstreet        :varchar_max(2147 default(""), not null
#  fmnotes          :varchar_max(2147 default(""), not null
#  fmremarks        :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fmtermsmsg       :varchar_max(2147 default(""), not null
#  flduechng        :boolean          default(FALSE), not null
#  fccontkey        :char(10)         default("          "), not null
#  flcontract       :boolean          default(FALSE), not null
#  fldifmsg         :boolean          default(FALSE), not null
#  ContractNu       :varchar(10)      default(""), not null
#  fbilladdr        :varchar(6)       default(""), not null
#  flpaybycc        :boolean          default(FALSE), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Invoice < M2m::Base
  self.table_name = 'armast'
  self.primary_key = 'fcinvoice'

  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => 'fsono', :primary_key => 'fsono'
  has_many :items, :class_name => 'M2m::InvoiceItem', :foreign_key => 'fcinvoice', :primary_key => 'fcinvoice'
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :foreign_key => 'fsalespn', :primary_key => 'fsalespn'
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :fcsourceid, :primary_key => :fcustno

  alias_attribute :invoice_source_code, :fcsource
  alias_attribute :invoice_type_code, :finvtype
  alias_attribute :amount, :fnamount
  alias_date_attribute :date, :finvdate
  alias_date_attribute :due_date, :fduedate
  alias_date_attribute :gl_date, :fdgldate
  alias_attribute :invoice_number, :fcinvoice
  alias_attribute :customer_number, :fcustno
  alias_attribute :printed?, :flisprint
  alias_attribute :commission_percentage, :fsalcompct
  alias_attribute :sales_person_key, :fsalespn
  alias_attribute :sales_order_number, :fsono
  alias_attribute :number, :fnumber

  scope :customer, -> (customer) {
    custno = customer.is_a?(M2m::Customer) ? customer.customer_number : customer
    where :fcustno => custno
  }
  scope :invoice_dates, -> (start_date, end_date) {
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where [ 'armast.finvdate >= ? and armast.finvdate < ?', start_date, end_date ]
  }
  scope :before, -> (end_date) {
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where [ 'armast.finvdate < ?', end_date ]
  }
  scope :after, -> (start_date) {
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    where [ 'armast.finvdate >= ?', start_date ]
  }
  # TODO: Replace 'V' with something intelligent?
  scope :not_void, -> { where([ 'armast.fcstatus != ? ', 'V' ]) }
  scope :unpaid, -> { where([ 'armast.fcstatus = ?', ['U'] ]) }
  scope :unpaid_or_partial, -> { where([ 'armast.fcstatus in (?)', ['U', 'P'] ]) }
  scope :not_paid_before, -> (date) {
    date = DateParser.parse(date) if date.is_a?(String)
    where [ 'armast.fdfactdate IS NULL or armast.fdfactdate >= ?', date]
  }
  scope :by_date, -> { order(:finvdate) }
  scope :for_date, -> (date) {
    where [ 'armast.finvdate >= ? and armast.finvdate < ?', date, date.advance(:days => 1) ]
  }
  scope :invoice_number, -> (n) {
    # Zero pad.
    n = "%010d" % n if n.is_a?(Fixnum)
    where :fcinvoice => n
  }
  scope :normal_type, -> { where([ 'armast.finvtype = ?', 'N' ]) }
  scope :credit_memo, -> { where([ 'armast.finvtype = ?', 'C' ]) }
  scope :prepayment, -> { where([ 'armast.finvtype = ?', 'P' ]) }

  def self.invoice_numbers(numbers)
    where ['armast.fcinvoice in (?)', numbers]
  end
  def self.part_number_like(part_number)
    joins(:items).where(['aritem.fpartno like ?', '%' + part_number + '%'])
  end

  def invoice_type
    M2m::InvoiceType.find_by_key(self.invoice_type_code)
  end
  def invoice_type_name
    self.invoice_type.try(:name)
  end

  def invoice_source
    M2m::InvoiceSource.find_by_key(self.invoice_source_code)
  end

  def self.format_invoice_number(invoice_type, invoice_number)
    # Zero pad.
    if invoice_type.credit_memo?
      'CM-' + "%07d" % invoice_number
    elsif invoice_type.pre_payment_memo?
      'PM-' + "%07d" % invoice_number
    else
      "%010d" % invoice_number
    end
  end

  def status_name
    if popup = M2m::CsPopup.cached_lookup('ARMAST.FCSTATUS', self.fcstatus)
      popup.text.strip
    else
      nil
    end
  end

  def paid?
    self.fcstatus == 'F'
  end

  def void?
    self.fcstatus == 'V'
  end

  def customer_name
    M2m::Customer.customer_name(self.fbcompany)
  end

  def self.attach_invoices(objects, invoices=nil)
    invoices ||= M2m::Invoice.invoice_numbers(objects.map(&:invoice_number).uniq)
    invoice_hash = {}
    invoices.each { |i| invoice_hash[i.invoice_number] = i }
    result = []
    objects.each do |o|
      if found = invoice_hash[o.invoice_number]
        result.push o.invoice = found
      else
        # Explicitly set this to keep it from trying to lazy load.
        o.invoice = nil
      end
    end
    result
  end


end
