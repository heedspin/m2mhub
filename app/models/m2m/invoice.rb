# == Schema Information
#
# Table name: armast
#
#  fbcity           :string(20)       default(""), not null
#  fbcompany        :string(35)       default(""), not null
#  fbcountry        :string(25)       default(""), not null
#  fbstate          :string(20)       default(""), not null
#  fbzip            :string(10)       default(""), not null
#  fccity           :string(20)       default(""), not null
#  fccompany        :string(35)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  fcstate          :string(20)       default(""), not null
#  fczip            :string(10)       default(""), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  fcinvoice        :string(20)       default(""), not null, primary key
#  fcsource         :string(1)        default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fctermsid        :string(4)        default(""), not null
#  fctime_ts        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcustno          :string(6)        default(""), not null
#  fdfactdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdgldate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fduedate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ffreight         :decimal(, )      default(0.0), not null
#  ffob             :string(20)       default(""), not null
#  finvdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fliscod          :boolean          default(FALSE), not null
#  flishand         :boolean          default(FALSE), not null
#  flisprint        :boolean          default(FALSE), not null
#  flpostnow        :boolean          default(FALSE), not null
#  finvtype         :string(1)        default(""), not null
#  fnamount         :decimal(, )      default(0.0), not null
#  fngoodsamt       :decimal(, )      default(0.0), not null
#  fncredits        :decimal(, )      default(0.0), not null
#  fncurex          :decimal(, )      default(0.0), not null
#  fninvdisrt       :decimal(11, 5)   default(0.0), not null
#  fnfinchg         :decimal(, )      default(0.0), not null
#  fnpaytype        :integer          default(0), not null
#  fntotalwt        :decimal(12, 4)   default(0.0), not null
#  fnumber          :string(25)       default("")
#  fpaidref         :string(20)       default(""), not null
#  fpono            :string(20)       default(""), not null
#  fretrndate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fsalespn         :string(3)        default(""), not null
#  fshipdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fshipvia         :string(10)       default(""), not null
#  fsono            :string(6)        default(""), not null
#  ftaxamt          :decimal(, )      default(0.0), not null
#  ftaxcode         :string(3)        default(""), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fdeurodate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fdvoiddate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flpremcv         :boolean          default(FALSE), not null
#  fdtaxpoint       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fldifmsg         :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fmbstreet        :text             default(""), not null
#  fmnotes          :text             default(""), not null
#  fmremarks        :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fmtermsmsg       :text             default(""), not null
#  fccontkey        :string(10)       default(""), not null
#  flcontract       :boolean          default(FALSE), not null
#  flduechng        :boolean          default(FALSE), not null
#  ContractNu       :string(10)       default(""), not null
#  fbilladdr        :string(4)        default(""), not null
#

class M2m::Invoice < M2m::Base
  self.table_name = 'armast'
  self.primary_key = 'fcinvoice'

  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => 'fsono', :primary_key => 'fsono'
  has_many :items, :class_name => 'M2m::InvoiceItem', :foreign_key => 'fcinvoice', :primary_key => 'fcinvoice'
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :foreign_key => 'fsalespn', :primary_key => 'fsalespn'

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

  scope :customer, lambda { |customer|
    custno = customer.is_a?(M2m::Customer) ? customer.customer_number : customer
    {
      :conditions => { :fcustno => custno }
    }
  }
  scope :invoice_dates, lambda { |start_date, end_date|
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'armast.finvdate >= ? and armast.finvdate < ?', start_date, end_date ]
    }
  }
  scope :before, lambda { |end_date|
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'armast.finvdate < ?', end_date ]
    }
  }
  # TODO: Replace 'V' with something intelligent?
  scope :not_void, :conditions => [ 'armast.fcstatus != ? ', 'V' ]
  scope :by_date, :order => :finvdate
  scope :for_date, lambda { |date|
    {
      :conditions => [ 'armast.finvdate >= ? and armast.finvdate < ?', date, date.advance(:days => 1) ]
    }
  }
  scope :invoice_number, lambda { |n|
    # Zero pad.
    n = "%010d" % n if n.is_a?(Fixnum)
    {
      :conditions => { :fcinvoice => n }
    }
  }
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

end
