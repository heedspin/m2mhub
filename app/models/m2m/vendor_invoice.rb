# == Schema Information
#
# Table name: apmast
#
#  fcinvoice        :char(20)         default("                    "), not null
#  fvendno          :char(6)          default("      "), not null
#  fccompany        :varchar(35)      default(""), not null
#  fnamount         :money            default(0.0), not null
#  fpaid            :money            default(0.0), not null
#  fccity           :char(20)         default("                    "), not null
#  fcstate          :char(20)         default("                    "), not null
#  fadjamt          :money            default(0.0), not null
#  fapppay          :money            default(0.0), not null
#  fnappadj         :money            default(0.0), not null
#  fnappdis         :money            default(0.0), not null
#  fccheckref       :char(26)         default("                          "), not null
#  fccountry        :char(25)         default("                         "), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  fcsource         :char(1)          default(" "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fctermsid        :char(4)          default("    "), not null
#  fczip            :char(10)         default("          "), not null
#  fdebit           :money            default(0.0), not null
#  fdfactdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdiscamt         :money            default(0.0), not null
#  fdiscdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdisctake        :money            default(0.0), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffreight         :money            default(0.0), not null
#  fgldisdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finvdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finvtype         :char(2)          default("  "), not null
#  flpaydate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flpayment        :money            default(0.0), not null
#  fltxnpaymt       :money            default(0.0), not null
#  fleurpaymt       :money            default(0.0), not null
#  flisprint        :boolean          default(FALSE), not null
#  flpostnow        :boolean          default(FALSE), not null
#  fncredits        :money            default(0.0), not null
#  fncurex          :money            default(0.0), not null
#  fngoodsamt       :money            default(0.0), not null
#  fnondisc         :money            default(0.0), not null
#  fnpaytype        :integer          default(0), not null
#  fpono            :varchar(10)      default(""), not null
#  freceiver        :varchar(10)      default(""), not null
#  freturn          :char(1)          default(" "), not null
#  frmpono          :varchar(10)      default(""), not null
#  ftaxamt          :money            default(0.0), not null
#  furgency         :integer          default(0), not null
#  fappeurpay       :money            default(0.0), not null
#  fapptxnpay       :money            default(0.0), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  feuradjamt       :money            default(0.0), not null
#  feurapadj        :money            default(0.0), not null
#  feurapdis        :money            default(0.0), not null
#  feurdistk        :money            default(0.0), not null
#  feuropaid        :money            default(0.0), not null
#  ftxnadjamt       :money            default(0.0), not null
#  ftxnapadj        :money            default(0.0), not null
#  ftxnapdis        :money            default(0.0), not null
#  ftxndistk        :money            default(0.0), not null
#  ftxnpaid         :money            default(0.0), not null
#  fcurrpaid        :char(1)          default(" "), not null
#  fdvoiddate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flduechng        :boolean          default(FALSE), not null
#  flpremcv         :boolean          default(FALSE), not null
#  fdtaxpoint       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmnotes          :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fleftisprint     :boolean          default(FALSE), not null
#  fnpaymode        :integer          default(0), not null
#  fneftapppay      :decimal(22, 5)   default(0.0), not null
#  fneftapptxnpay   :decimal(22, 5)   default(0.0), not null
#  fneftappadj      :decimal(22, 5)   default(0.0), not null
#  fnefttxnapadj    :decimal(22, 5)   default(0.0), not null
#  fneftappdis      :decimal(22, 5)   default(0.0), not null
#  fnefttxnapdis    :decimal(22, 5)   default(0.0), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::VendorInvoice < M2m::Base
  self.table_name = 'apmast'    
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno

  alias_attribute :vendor_number, :fvendno
  alias_attribute :invoice_number, :fcinvoice
  alias_attribute :amount, :fnamount
  alias_attribute :vendor_name, :fccompany
  alias_attribute :status, :fcstatus

  alias_attribute :pay_date, :flpaydate
  def pay_date
    M2m::Constants.sanitize_date(self.flpaydate)
  end

  alias_attribute :date, :finvdate
  def date
    M2m::Constants.sanitize_date(self.finvdate)
  end
  
  def self.invoice_number(num)
    where :fcinvoice => num
  end
  scope :purchase_order_number, -> (num) {
    where :fpono => num
  }
  def self.invoice_dates(start_date, end_date)
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where [ 'apmast.finvdate >= ? and apmast.finvdate < ?', start_date, end_date ]
  end
  def self.invoice_number_like(text)
    where ['apmast.fcinvoice like ?', '%' + text + '%']
  end
  scope :by_date_desc, -> { order('apmast.finvdate desc') }
  def self.vendor_number(num)
    where :fvendno => M2m::Vendor.pad_vendor_number(num)
  end
  def self.vendor_account_number(num)
    joins(:vendor).where(:apvend => { :fcacctnum => num.to_s })
  end
  scope :unpaid_or_partial, -> { where([ 'apmast.fcstatus in (?)', ['U', 'P'] ]) }
  scope :partial, -> { where([ 'apmast.fcstatus in (?)', ['P'] ]) }
  scope :unpaid, -> { where([ 'apmast.fcstatus in (?)', ['U'] ]) }
  scope :not_void, -> { where('apmast.fcstatus != ?', 'V') }

  scope :normal, -> { where('apmast.finvtype = ?', 'N')}
  scope :miscellaneous, -> { where('apmast.finvtype = ?', 'M')}
  scope :debit_memo, -> { where('apmast.finvtype = ?', 'DM')}

  def not_void?
    self.fcstatus != 'V'
  end
  
  def item_invoice_key
    "#{self.vendor_number}#{self.invoice_number}"
  end
  
  def items
    M2m::VendorInvoiceItem.invoice_key(self.item_invoice_key)
  end

  def paid?
    self.fcstatus == 'F'
  end

  def void?
    self.fcstatus == 'V'
  end  

  def partial?
    self.fcstatus == 'P'
  end

  def unpaid?
    self.fcstatus == 'U'
  end
end
