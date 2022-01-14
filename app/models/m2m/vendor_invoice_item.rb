# == Schema Information
#
# Table name: apitem
#
#  fapp_by          :char(3)          default("   "), not null
#  fapp_dt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccredit         :char(25)         default("                         "), not null
#  fcdebit          :char(25)         default("                         "), not null
#  fcinvkey         :varchar(26)      default(""), not null
#  fcpocat          :char(8)          default("        "), not null
#  fcprodcl         :varchar(4)       default(""), not null
#  fcsojokey        :varchar(20)      default(""), not null
#  fcsource         :char(1)          default(" "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fctype           :char(1)          default(" "), not null
#  flisvuom         :boolean          default(FALSE), not null
#  finvqty          :decimal(17, 5)   default(0.0), not null
#  fitemno          :char(6)          default("      "), not null
#  fmeasure         :char(3)          default("   "), not null
#  fndiscrate       :decimal(7, 3)    default(0.0), not null
#  fndisamt         :money            default(0.0), not null
#  fnexpcost        :decimal(17, 5)   default(0.0), not null
#  fnunit           :decimal(17, 5)   default(0.0), not null
#  fpartno          :char(25)         default("                         "), not null
#  frev             :char(3)          default("   "), not null
#  fpokey           :varchar(16)      default(""), not null
#  fprice           :money            default(0.0), not null
#  frecvkey         :varchar(13)      default(""), not null
#  fvconvfact       :decimal(11, 5)   default(0.0), not null
#  fvmeasure        :char(5)          default("     "), not null
#  fvpartno         :char(25)         default("                         "), not null
#  fvqtyinv         :decimal(17, 5)   default(0.0), not null
#  fvucost          :decimal(17, 5)   default(0.0), not null
#  fcshipkey        :varchar(16)      default(""), not null
#  feuroprice       :money            default(0.0), not null
#  fneurdisamt      :money            default(0.0), not null
#  fneurounit       :decimal(17, 5)   default(0.0), not null
#  fnexpeurcost     :decimal(17, 5)   default(0.0), not null
#  fnexptxncost     :decimal(17, 5)   default(0.0), not null
#  fntxndisamt      :money            default(0.0), not null
#  fntxnunit        :decimal(17, 5)   default(0.0), not null
#  ftxnprice        :money            default(0.0), not null
#  fvueurocost      :decimal(17, 5)   default(0.0), not null
#  fvutxncost       :decimal(17, 5)   default(0.0), not null
#  fljrdif          :boolean          default(FALSE), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fctaxitemno      :char(6)          default("      "), not null
#  fctaxcode        :char(10)         default("          "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmdescr          :varchar_max(2147 default(""), not null
#  fmnotes          :varchar_max(2147 default(""), not null
#  fvptdes          :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  ffixcosttxn      :decimal(17, 5)   default(0.0), not null
#  fixcstrecv       :decimal(17, 5)   default(0.0), not null
#  fvendno          :char(6)          default("      "), not null
#  finvoice         :varchar(20)      default(""), not null
#  FPONO            :varchar(10)      default(""), not null
#  FPOITEMNO        :varchar(3)       default(""), not null
#  FPORELSNO        :varchar(3)       default(""), not null
#  FRECEIVER        :varchar(10)      default(""), not null
#  FRECVITEMNO      :varchar(3)       default(""), not null
#  FCSONO           :varchar(10)      default(""), not null
#  FINUMBER         :varchar(3)       default(""), not null
#  FRELEASE         :varchar(3)       default(""), not null
#  FCJOBNO          :varchar(20)      default(""), not null
#  FSHIPNO          :varchar(10)      default(""), not null
#  FSHIPITEMNO      :varchar(6)       default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::VendorInvoiceItem < M2m::Base
  self.table_name = 'apitem'
  # This does not work because of the evil M2M fcinvkey terribleness...
  # belongs_to :invoice, :class_name => 'M2m::VendorInvoice', :foreign_key => 'fcinvkey'

  alias_attribute :unit_cost, :fvucost
  
  def invoice
    @invoice ||= M2m::VendorInvoice.invoice_number(self.invoice_number).first # .purchase_order_number(self.purchase_order_number)
  end
  # This is for caching, not actual assignment, fools...
  def invoice=(v)
    @invoice = v
  end

  def self.invoice_dates(start_date, end_date)
    start_date = DateParser.parse(start_date) unless start_date.is_a?(Date)
    end_date = DateParser.parse(end_date) unless end_date.is_a?(Date)
    joins(:invoice).where(['apmast.finvdate >= ? and apmast.finvdate < ?', start_date, end_date])
  end
  # scope :not_void, -> { joins(:invoice).where([ 'apmast.fcstatus != ? ', 'V' ]) }

  belongs_to_item :fpartno, :frev
  scope :part_number, -> (pn) { where(:fpartno => pn) }
  scope :vendor, -> (v) {
    v = v.vendor_number if v.is_a?(M2m::Vendor)
    where [ 'SUBSTRING(apitem.fcinvkey,1,6) = ?', v.to_s]
  }
  scope :invoice_key, -> (ik) {
    where :fcinvkey => ik
  }
  alias_attribute :invoice_key, :fcinvkey
  def invoice_number
    @invoice_number ||= self.invoice_key[6..25]
  end
  def purchase_order_number
    @purchase_order_number ||= self.invoice_key[0..5]
  end
end
