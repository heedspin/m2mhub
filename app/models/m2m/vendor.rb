class M2m::Vendor < M2m::Base
  set_table_name 'apvend'
  set_primary_key 'fvendno'
  alias_attribute :vendor_number, :fvendno
  alias_attribute :name, :fcompany
  has_many :inventory_vendors, :class_name => 'M2m::InventoryVendor', :foreign_key => :fvendno, :primary_key => :fvendno
end


# == Schema Information
#
# Table name: apvend
#
#  fvendno          :string(6)       not null, primary key
#  fcompany         :string(35)      not null
#  fbuyer           :string(3)       not null
#  fcacctnum        :string(25)      not null
#  fccusno          :string(20)      not null
#  fcdefshpto       :string(4)       not null
#  fcity            :string(20)      not null
#  fcountry         :string(25)      not null
#  fcfname          :string(15)      not null
#  fcontact         :string(20)      not null
#  fcshipvia        :string(20)      not null
#  fcterms          :string(4)       not null
#  fccurid          :string(3)       not null
#  fcuser1          :string(40)      not null
#  fcuser2          :string(40)      not null
#  fcuser3          :string(40)      not null
#  fduser1          :datetime        not null
#  fdsince          :datetime        not null
#  ffax             :string(20)      not null
#  fiso9000         :boolean         not null
#  flimit           :decimal(, )     not null
#  fllongdist       :boolean         not null
#  fnminamt         :decimal(, )     not null
#  fnuser1          :decimal(17, 5)  not null
#  fnuser2          :decimal(17, 5)  not null
#  fphone           :string(20)      not null
#  fprepaid         :decimal(, )     not null
#  fsalestax        :decimal(7, 3)   not null
#  fstate           :string(20)      not null
#  fstatus          :string(1)       not null
#  furgency         :integer(4)      not null
#  fdramt           :decimal(, )     not null
#  fvtype           :string(2)       not null
#  fzip             :string(10)      not null
#  f1099            :boolean         not null
#  fcstatus         :string(1)       not null
#  flistaxabl       :boolean         not null
#  fcemail          :string(60)      not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fmstreet         :text            not null
#  fmuser1          :text            not null
#  fdisttype        :string(10)      not null
#  flpayment        :decimal(, )
#  flpaydate        :datetime
#  fytdpur          :decimal(, )
#  fbal             :decimal(, )
#

