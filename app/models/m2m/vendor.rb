# == Schema Information
#
# Table name: apvend
#
#  fvendno          :char(6)          not null
#  fcompany         :varchar(35)      not null
#  fbuyer           :char(3)          not null
#  fcacctnum        :char(25)         not null
#  fccusno          :char(20)         not null
#  fcdefshpto       :varchar(6)       not null
#  fcity            :char(20)         not null
#  fcountry         :char(25)         not null
#  fcfname          :char(15)         not null
#  fcontact         :char(20)         not null
#  fcshipvia        :char(20)         not null
#  fcterms          :char(4)          not null
#  fccurid          :char(3)          not null
#  fcuser1          :varchar(40)      not null
#  fcuser2          :varchar(40)      not null
#  fcuser3          :varchar(40)      not null
#  fduser1          :datetime         not null
#  fdsince          :datetime         not null
#  ffax             :char(20)         not null
#  fiso9000         :boolean          not null
#  flimit           :money            not null
#  fllongdist       :boolean          not null
#  fnminamt         :money            not null
#  fnuser1          :decimal(17, 5)   not null
#  fnuser2          :decimal(17, 5)   not null
#  fphone           :char(20)         not null
#  fprepaid         :money            not null
#  fsalestax        :decimal(7, 3)    default(0.0), not null
#  fstate           :char(20)         not null
#  fstatus          :char(1)          not null
#  furgency         :integer          not null
#  fdramt           :money            not null
#  fvtype           :char(2)          not null
#  fzip             :char(10)         not null
#  f1099            :boolean          not null
#  fcstatus         :char(1)          not null
#  flistaxabl       :boolean          not null
#  fcemail          :varchar(100)     not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmstreet         :varchar_max(2147 not null
#  fmuser1          :varchar_max(2147 not null
#  fdisttype        :varchar(10)      not null
#  fchangeby        :char(25)         not null
#  fcngdate         :datetime         not null
#  fcsubstatus      :char(1)          not null
#  freasoncng       :varchar_max(2147 not null
#  fnremdelivery    :integer          not null
#  fvremadvmail     :varchar(100)     not null
#  fvremadvfax      :varchar(20)      not null
#  fleftvend        :boolean          not null
#  ftaxid           :varchar(50)      not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#  flpayment        :money
#  flpaydate        :datetime
#  fytdpur          :decimal(38, 9)
#  fbal             :money
#

class M2m::Vendor < M2m::Base
  include M2m::CachedAddresses
  self.table_name = 'apvend'
  alias_attribute :vendor_number, :fvendno
  has_many :inventory_vendors, :class_name => 'M2m::InventoryVendor', :foreign_key => :fvendno, :primary_key => :fvendno
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'
  has_many :addresses, -> { where(fcalias: 'APVEND') }, :class_name => 'M2m::Address', :foreign_key => 'fcaliaskey', :primary_key => 'fvendno'
  has_many :contacts, -> { where(fcs_alias: 'APVEND') }, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fvendno'
  
  scope :with_vendor_numbers, -> (vendor_numbers) {
    where [ 'apvend.fvendno in (?)', vendor_numbers ]
  }
  scope :by_name, -> { order(:fcompany) }
  scope :name_like, -> (txt) {
    where [ 'apvend.fcompany like ?', '%' + (txt || '') + '%' ]
  }
  scope :with_name, -> (txt) {
    where [ 'apvend.fcompany = ?', txt.ljust(35) ]
  }
  
  def name
    @name ||= self.class.safe_titleize(self.fcompany)
  end

  def self.pad_vendor_number(txt)
    "%06d" % txt.to_i
  end
  
end

