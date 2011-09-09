class M2m::SalesOrder < M2m::Base
  set_table_name 'somast'
  
  has_many :items, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fsono
  
  named_scope :open,      :conditions => { :fstatus => M2m::SalesOrderStatus.open.name }
  named_scope :closed,    :conditions => { :fstatus => M2m::SalesOrderStatus.closed.name }
  named_scope :cancelled, :conditions => { :fstatus => M2m::SalesOrderStatus.cancelled.name }
end
# == Schema Information
#
# Table name: somast
#
#  fsono            :string(6)       not null
#  fcustno          :string(6)       not null
#  fcompany         :string(35)      default(" "), not null
#  fcity            :string(20)      not null
#  fcustpono        :string(20)      not null
#  fackdate         :datetime        not null
#  fcanc_dt         :datetime        not null
#  fccurid          :string(3)       not null
#  fcfactor         :decimal(17, 5)  not null
#  fcfname          :string(15)      not null
#  fcfromno         :string(6)       not null
#  fcfromtype       :string(5)       not null
#  fcontact         :string(30)      default(" "), not null
#  fclos_dt         :datetime        not null
#  fcountry         :string(25)      not null
#  fcusrchr1        :string(20)      not null
#  fcusrchr2        :string(40)      default(" "), not null
#  fcusrchr3        :string(40)      default(" "), not null
#  fdcurdate        :datetime        not null
#  fdisrate         :decimal(8, 3)   not null
#  fdistno          :string(6)       not null
#  fduedate         :datetime        not null
#  fduplicate       :boolean         not null
#  fdusrdate1       :datetime        not null
#  festimator       :string(3)       not null
#  ffax             :string(20)      not null
#  ffob             :string(20)      not null
#  fnextenum        :string(3)       not null
#  fnextinum        :string(3)       not null
#  fnusrqty1        :decimal(15, 5)  not null
#  fnusrcur1        :decimal(17, 5)  not null
#  forderdate       :datetime        not null
#  fordername       :string(35)      default(" "), not null
#  fordrevdt        :datetime        not null
#  fpaytype         :string(1)       not null
#  fphone           :string(20)      not null
#  fprint_dt        :datetime        not null
#  fprinted         :boolean         not null
#  fsalcompct       :decimal(8, 3)   not null
#  fsalecom         :boolean         not null
#  fshipvia         :string(20)      not null
#  fshptoaddr       :string(4)       not null
#  fsocoord         :string(3)       not null
#  fsoldaddr        :string(4)       not null
#  fsoldby          :string(3)       not null
#  fsorev           :string(2)       not null
#  fstate           :string(20)      not null
#  fstatus          :string(20)      not null
#  ftaxcode         :string(3)       not null
#  ftaxrate         :decimal(7, 3)   not null
#  fterm            :string(4)       not null
#  fterr            :string(10)      not null
#  fzip             :string(10)      not null
#  flprofprtd       :boolean         not null
#  flprofrqd        :boolean         not null
#  fndpstrcvd       :decimal(17, 5)  not null
#  fndpstrqd        :decimal(17, 5)  not null
#  fdeurodate       :datetime        not null
#  feurofctr        :decimal(17, 5)  not null
#  fsalescode       :string(7)       not null
#  fusercode        :string(7)       not null
#  fncancchrge      :decimal(17, 5)  not null
#  flchgpnd         :boolean         not null
#  fllasteco        :string(25)      not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fackmemo         :text            default(" "), not null
#  fmstreet         :text            default(" "), not null
#  fmusrmemo1       :text            default(" "), not null
#  fccontkey        :string(10)      default(" "), not null
#  flcontract       :boolean         default(FALSE), not null
#  fndbrmod         :integer         default(0), not null
#  fccommcode       :string(10)      default(""), not null
#  fpriority        :integer(4)      default(4), not null
#
