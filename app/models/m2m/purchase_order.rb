class M2m::PurchaseOrder < M2m::Base
  set_table_name 'pomast'
  set_primary_key 'fpono'
  
  has_many :items, :class_name => 'M2m::PurchaseOrderItem', :foreign_key => :fpono, :primary_key => :fpono  

  named_scope :open,      :conditions => { :fstatus => M2m::Status.open.name }
  named_scope :closed,    :conditions => { :fstatus => M2m::Status.closed.name }
  named_scope :cancelled, :conditions => { :fstatus => M2m::Status.cancelled.name }

  def status
    self.fstatus.downcase.capitalize
  end
  
  def closed?
    self.fstatus.downcase.strip == 'closed'
  end
  
end

# == Schema Information
#
# Table name: pomast
#
#  fcompany         :string(35)      default(" "), not null
#  fcshipto         :string(8)       not null
#  forddate         :datetime        not null
#  fpono            :string(6)       not null, primary key
#  fstatus          :string(20)      not null
#  fvendno          :string(6)       not null
#  fbuyer           :string(3)       not null
#  fchangeby        :string(25)      not null
#  fcngdate         :datetime        not null
#  fconfirm         :string(19)      not null
#  fcontact         :string(20)      not null
#  fcfname          :string(15)      not null
#  fcreate          :datetime        not null
#  ffob             :string(20)      not null
#  fmethod          :string(1)       not null
#  foldstatus       :string(20)      not null
#  fordrevdt        :datetime        not null
#  fordtot          :decimal(15, 5)  not null
#  fpayterm         :string(4)       not null
#  fpaytype         :string(1)       not null
#  fporev           :string(2)       not null
#  fprint           :string(1)       not null
#  freqdate         :datetime        not null
#  freqsdt          :datetime        not null
#  freqsno          :string(6)       not null
#  frevtot          :decimal(15, 5)  not null
#  fsalestax        :decimal(7, 3)   not null
#  fshipvia         :string(20)      not null
#  ftax             :string(1)       not null
#  fcsnaddrke       :string(4)       not null
#  fcsncity         :string(20)      not null
#  fcsnstate        :string(20)      not null
#  fcsnzip          :string(10)      not null
#  fcsncountr       :string(25)      not null
#  fcsnphone        :string(20)      not null
#  fcsnfax          :string(20)      not null
#  fcshkey          :string(6)       not null
#  fcshaddrke       :string(4)       not null
#  fcshcompan       :string(35)      default(" "), not null
#  fcshcity         :string(20)      not null
#  fcshstate        :string(20)      not null
#  fcshzip          :string(10)      not null
#  fcshcountr       :string(25)      not null
#  fcshphone        :string(20)      not null
#  fcshfax          :string(20)      not null
#  fnnextitem       :integer         not null
#  fautoclose       :string(1)       not null
#  fcusrchr1        :string(20)      not null
#  fcusrchr2        :string(40)      default(" "), not null
#  fcusrchr3        :string(40)      default(" "), not null
#  fnusrqty1        :decimal(17, 5)  not null
#  fnusrcur1        :decimal(, )     not null
#  fdusrdate1       :datetime        not null
#  fccurid          :string(3)       not null
#  fcfactor         :decimal(17, 5)  not null
#  fdcurdate        :datetime        not null
#  fdeurodate       :datetime        not null
#  feurofctr        :decimal(17, 5)  not null
#  fctype           :string(1)       not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fmpaytype        :text            default(" "), not null
#  fmshstreet       :text            default(" "), not null
#  fmsnstreet       :text            default(" "), not null
#  fmusrmemo1       :text            default(" "), not null
#  fpoclosing       :text            default(" "), not null
#  freasoncng       :text            default(" "), not null
#  fndbrmod         :integer         default(0), not null
#

