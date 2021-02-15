# == Schema Information
#
# Table name: apmast
#
#  fcinvoice        :string(20)       default(""), not null
#  fvendno          :string(6)        default(""), not null
#  fccompany        :string(35)       default(""), not null
#  fnamount         :decimal(, )      default(0.0), not null
#  fpaid            :decimal(, )      default(0.0), not null
#  fccity           :string(20)       default(""), not null
#  fcstate          :string(20)       default(""), not null
#  fadjamt          :decimal(, )      default(0.0), not null
#  fapppay          :decimal(, )      default(0.0), not null
#  fnappadj         :decimal(, )      default(0.0), not null
#  fnappdis         :decimal(, )      default(0.0), not null
#  fccheckref       :string(20)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  fcsource         :string(1)        default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fctermsid        :string(4)        default(""), not null
#  fczip            :string(10)       default(""), not null
#  fdebit           :decimal(, )      default(0.0), not null
#  fdfactdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdiscamt         :decimal(, )      default(0.0), not null
#  fdiscdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdisctake        :decimal(, )      default(0.0), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffreight         :decimal(, )      default(0.0), not null
#  fgldisdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finvdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finvtype         :string(2)        default(""), not null
#  flpaydate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flpayment        :decimal(, )      default(0.0), not null
#  fltxnpaymt       :decimal(, )      default(0.0), not null
#  fleurpaymt       :decimal(, )      default(0.0), not null
#  flisprint        :boolean          default(FALSE), not null
#  flpostnow        :boolean          default(FALSE), not null
#  fncredits        :decimal(, )      default(0.0), not null
#  fncurex          :decimal(, )      default(0.0), not null
#  fngoodsamt       :decimal(, )      default(0.0), not null
#  fnondisc         :decimal(, )      default(0.0), not null
#  fnpaytype        :integer          default(0), not null
#  fpono            :string(6)        default(""), not null
#  freceiver        :string(6)        default(""), not null
#  freturn          :string(1)        default(""), not null
#  frmpono          :string(6)        default(""), not null
#  ftaxamt          :decimal(, )      default(0.0), not null
#  furgency         :integer          default(0), not null
#  fappeurpay       :decimal(, )      default(0.0), not null
#  fapptxnpay       :decimal(, )      default(0.0), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  feuradjamt       :decimal(, )      default(0.0), not null
#  feurapadj        :decimal(, )      default(0.0), not null
#  feurapdis        :decimal(, )      default(0.0), not null
#  feurdistk        :decimal(, )      default(0.0), not null
#  feuropaid        :decimal(, )      default(0.0), not null
#  ftxnadjamt       :decimal(, )      default(0.0), not null
#  ftxnapadj        :decimal(, )      default(0.0), not null
#  ftxnapdis        :decimal(, )      default(0.0), not null
#  ftxndistk        :decimal(, )      default(0.0), not null
#  ftxnpaid         :decimal(, )      default(0.0), not null
#  fcurrpaid        :string(1)        default(""), not null
#  fdvoiddate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flduechng        :boolean          default(FALSE), not null
#  flpremcv         :boolean          default(FALSE), not null
#  fdtaxpoint       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmnotes          :text             default(""), not null
#  fmstreet         :text             default(""), not null
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
    where [ '[apmast].[finvdate] >= ? and [apmast].[finvdate] < ?', start_date, end_date ]
  end
  def self.invoice_number_like(text)
    where ['[apmast].[fcinvoice] like ?', '%' + text + '%']
  end
  scope :by_date_desc, -> { order('[apmast].[finvdate] desc') }
  def self.vendor_number(num)
    where :fvendno => M2m::Vendor.pad_vendor_number(num)
  end
  def self.vendor_account_number(num)
    joins(:vendor).where(:apvend => { :fcacctnum => num.to_s })
  end
  scope :not_void, -> { where('[apmast].[fcstatus] != ?', 'V') }
  
  def item_invoice_key
    "#{self.vendor_number}#{self.invoice_number}"
  end
  
  def items
    M2m::VendorInvoiceItem.invoice_key(self.item_invoice_key)
  end
end
