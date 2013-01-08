# == Schema Information
#
# Table name: apitem
#
#  fapp_by          :string(3)       default(""), not null
#  fapp_dt          :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fccredit         :string(25)      default(""), not null
#  fcdebit          :string(25)      default(""), not null
#  fcinvkey         :string(26)      default(""), not null
#  fcpocat          :string(8)       default(""), not null
#  fcprodcl         :string(2)       default(""), not null
#  fcsojokey        :string(12)      default(""), not null
#  fcsource         :string(1)       default(""), not null
#  fcstatus         :string(1)       default(""), not null
#  fctype           :string(1)       default(""), not null
#  flisvuom         :boolean         default(FALSE), not null
#  finvqty          :decimal(17, 5)  default(0.0), not null
#  fitemno          :string(6)       default(""), not null
#  fmeasure         :string(3)       default(""), not null
#  fndiscrate       :decimal(7, 3)   default(0.0), not null
#  fndisamt         :decimal(, )     default(0.0), not null
#  fnexpcost        :decimal(17, 5)  default(0.0), not null
#  fnunit           :decimal(17, 5)  default(0.0), not null
#  fpartno          :string(25)      default(""), not null
#  frev             :string(3)       default(""), not null
#  fpokey           :string(12)      default(""), not null
#  fprice           :decimal(, )     default(0.0), not null
#  frecvkey         :string(9)       default(""), not null
#  fvconvfact       :decimal(11, 5)  default(0.0), not null
#  fvmeasure        :string(5)       default(""), not null
#  fvpartno         :string(25)      default(""), not null
#  fvqtyinv         :decimal(17, 5)  default(0.0), not null
#  fvucost          :decimal(17, 5)  default(0.0), not null
#  fcshipkey        :string(12)      default(""), not null
#  feuroprice       :decimal(, )     default(0.0), not null
#  fneurdisamt      :decimal(, )     default(0.0), not null
#  fneurounit       :decimal(17, 5)  default(0.0), not null
#  fnexpeurcost     :decimal(17, 5)  default(0.0), not null
#  fnexptxncost     :decimal(17, 5)  default(0.0), not null
#  fntxndisamt      :decimal(, )     default(0.0), not null
#  fntxnunit        :decimal(17, 5)  default(0.0), not null
#  ftxnprice        :decimal(, )     default(0.0), not null
#  fvueurocost      :decimal(17, 5)  default(0.0), not null
#  fvutxncost       :decimal(17, 5)  default(0.0), not null
#  fljrdif          :boolean         default(FALSE), not null
#  flistaxabl       :boolean         default(FALSE), not null
#  fctaxitemno      :string(6)       default(""), not null
#  fctaxcode        :string(10)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fmdescr          :text            default(""), not null
#  fmnotes          :text            default(""), not null
#  fvptdes          :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#  ffixcost         :decimal(17, 5)  default(0.0), not null
#  ffixcosttxn      :decimal(17, 5)  default(0.0), not null
#

class M2m::VendorInvoiceItem < M2m::Base
  set_table_name 'apitem'
  belongs_to :invoice, :class_name => 'M2m::VendorInvoice', :foreign_key => 'fcinvkey'
  
  def invoice
    @invoice ||= M2m::VendorInvoice.invoice_number(self.invoice_number).first # .purchase_order_number(self.purchase_order_number)
  end
  
  belongs_to_item :fpartno, :frev
  scope :part_number, lambda { |pn| where(:fpartno => pn) }
  scope :vendor, lambda { |v|
    v = v.vendor_number if v.is_a?(M2m::Vendor)
    {
      :conditions => [ 'SUBSTRING(apitem.fcinvkey,1,6) = ?', v.to_s]
    }
  }
  scope :invoice_key, lambda { |ik|
    {
      :conditions => { :fcinvkey => ik }
    }
  }
  alias_attribute :invoice_key, :fcinvkey
  def invoice_number
    @invoice_number ||= self.invoice_key[6..25]
  end
  def purchase_order_number
    @purchase_order_number ||= self.invoice_key[0..5]
  end
end
