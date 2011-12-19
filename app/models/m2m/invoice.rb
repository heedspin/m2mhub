class M2m::Invoice < M2m::Base
  set_table_name 'armast'
  set_primary_key 'fcinvoice'

  # C - Credit Memo            
  # M - Miscellaneous Invoice  
  # N - Normal Invoice         
  # P - Pre-Payment Memo       
  # T - Time & Material Billing
  # V - Vendor Invoice         
  def invoice_type             
    M2m::CsPopup.for_key('ARMAST.FINVTYPE').with_code(self.invoice_type_code).first
  end
  def invoice_type_name
    self.invoice_type.try(:text)
  end
  
  def invoice_source
    M2m::InvoiceSource.find_by_key(self.invoice_source_code)
  end
  
  alias_attribute :invoice_source_code, :fcsource
  alias_attribute :invoice_type_code, :finvtype
  alias_attribute :amount, :fnamount
  alias_attribute :date, :finvdate
end

# == Schema Information
#
# Table name: armast
#
#  fbcity           :string(20)      not null
#  fbcompany        :string(35)      default(" "), not null
#  fbcountry        :string(25)      not null
#  fbstate          :string(20)      not null
#  fbzip            :string(10)      not null
#  fccity           :string(20)      not null
#  fccompany        :string(35)      default(" "), not null
#  fccountry        :string(25)      not null
#  fcstate          :string(20)      not null
#  fczip            :string(10)      not null
#  fccurid          :string(3)       not null
#  fcfactor         :decimal(17, 5)  not null
#  fcinvoice        :string(20)      not null, primary key
#  fcsource         :string(1)       not null
#  fcstatus         :string(1)       not null
#  fctermsid        :string(4)       not null
#  fctime_ts        :datetime        not null
#  fcustno          :string(6)       not null
#  fdfactdate       :datetime        not null
#  fdgldate         :datetime        not null
#  fduedate         :datetime        not null
#  ffreight         :decimal(, )     not null
#  ffob             :string(20)      not null
#  finvdate         :datetime        not null
#  fliscod          :boolean         not null
#  flishand         :boolean         not null
#  flisprint        :boolean         not null
#  flpostnow        :boolean         not null
#  finvtype         :string(1)       not null
#  fnamount         :decimal(, )     not null
#  fngoodsamt       :decimal(, )     not null
#  fncredits        :decimal(, )     not null
#  fncurex          :decimal(, )     not null
#  fninvdisrt       :decimal(11, 5)  not null
#  fnfinchg         :decimal(, )     not null
#  fnpaytype        :integer(4)      not null
#  fntotalwt        :decimal(12, 4)  not null
#  fnumber          :string(6)       not null
#  fpaidref         :string(20)      not null
#  fpono            :string(20)      not null
#  fretrndate       :datetime        not null
#  fsalespn         :string(3)       not null
#  fshipdate        :datetime        not null
#  fshipvia         :string(10)      not null
#  fsono            :string(6)       not null
#  ftaxamt          :decimal(, )     not null
#  ftaxcode         :string(3)       not null
#  fsalcompct       :decimal(8, 3)   not null
#  fdeurodate       :datetime        not null
#  feurofctr        :decimal(17, 5)  not null
#  fdvoiddate       :datetime        not null
#  flpremcv         :boolean         not null
#  fdtaxpoint       :datetime        not null
#  fldifmsg         :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fmbstreet        :text            default(" "), not null
#  fmnotes          :text            default(" "), not null
#  fmremarks        :text            default(" "), not null
#  fmstreet         :text            default(" "), not null
#  fmtermsmsg       :text            default(" "), not null
#  fccontkey        :string(10)      default(" "), not null
#  flcontract       :boolean         default(FALSE), not null
#  flduechng        :boolean         not null
#

