# == Schema Information
#
# Table name: pomast
#
#  fcompany         :string(35)       default(""), not null
#  fcshipto         :string(8)        default(""), not null
#  forddate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpono            :string(6)        default(""), not null, primary key
#  fstatus          :string(20)       default(""), not null
#  fvendno          :string(6)        default(""), not null
#  fbuyer           :string(3)        default(""), not null
#  fchangeby        :string(25)       default(""), not null
#  fcngdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fconfirm         :string(19)       default(""), not null
#  fcontact         :string(20)       default(""), not null
#  fcfname          :string(15)       default(""), not null
#  fcreate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffob             :string(20)       default(""), not null
#  fmethod          :string(1)        default(""), not null
#  foldstatus       :string(20)       default(""), not null
#  fordrevdt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fordtot          :decimal(15, 5)   default(0.0), not null
#  fpayterm         :string(4)        default(""), not null
#  fpaytype         :string(1)        default(""), not null
#  fporev           :string(2)        default(""), not null
#  fprint           :string(1)        default(""), not null
#  freqdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  freqsdt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  freqsno          :string(6)        default(""), not null
#  frevtot          :decimal(15, 5)   default(0.0), not null
#  fsalestax        :decimal(7, 3)    default(0.0), not null
#  fshipvia         :string(20)       default(""), not null
#  ftax             :string(1)        default(""), not null
#  fcsnaddrke       :string(4)        default(""), not null
#  fcsncity         :string(20)       default(""), not null
#  fcsnstate        :string(20)       default(""), not null
#  fcsnzip          :string(10)       default(""), not null
#  fcsncountr       :string(25)       default(""), not null
#  fcsnphone        :string(20)       default(""), not null
#  fcsnfax          :string(20)       default(""), not null
#  fcshkey          :string(6)        default(""), not null
#  fcshaddrke       :string(4)        default(""), not null
#  fcshcompan       :string(35)       default(""), not null
#  fcshcity         :string(20)       default(""), not null
#  fcshstate        :string(20)       default(""), not null
#  fcshzip          :string(10)       default(""), not null
#  fcshcountr       :string(25)       default(""), not null
#  fcshphone        :string(20)       default(""), not null
#  fcshfax          :string(20)       default(""), not null
#  fnnextitem       :integer          default(0), not null
#  fautoclose       :string(1)        default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(17, 5)   default(0.0), not null
#  fnusrcur1        :decimal(, )      default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  fdcurdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fctype           :string(1)        default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fmpaytype        :text             default(""), not null
#  fmshstreet       :text             default(""), not null
#  fmsnstreet       :text             default(""), not null
#  fmusrmemo1       :text             default(""), not null
#  fpoclosing       :text             default(""), not null
#  freasoncng       :text             default(""), not null
#  fndbrmod         :integer          default(0), not null
#  flpdate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#

class M2m::PurchaseOrder < M2m::Base
  self.table_name = 'pomast'
  self.primary_key = 'fpono'
  
  has_many :items, :class_name => 'M2m::PurchaseOrderItem', :foreign_key => :fpono, :primary_key => :fpono  
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno
  has_many :receivers, :class_name => 'M2m::Receiver', :foreign_key => :fpono, :primary_key => :fpono
  has_many :inspection_tasks, :class_name => 'Quality::InspectionTask', :foreign_key => :purchase_order_number

  scope :status_open,      :conditions => { :fstatus => M2m::PurchaseOrderStatus.open.name }
  scope :status_closed,    :conditions => { :fstatus => M2m::PurchaseOrderStatus.closed.name }
  scope :status_cancelled, :conditions => { :fstatus => M2m::PurchaseOrderStatus.cancelled.name }
  scope :inventory, :include => :items, :conditions => { :poitem => { :fcategory => 'INV     '} }
  
  alias_attribute :vendor_name, :fcompany
  alias_attribute :change_date, :fcngdate
  alias_attribute :purchase_order_number, :fpono
  alias_attribute :order_date, :forddate
  alias_attribute :fob, :ffob
  alias_attribute :vendor_number, :fvendno

  def status
    M2m::PurchaseOrderStatus.find_by_m2mname(self.fstatus.strip)
  end
  
  def closed?
    self.status.try(:closed?)
  end
  
  def self.pad_purchase_order_number(number)
    "%06d" % number.to_i
  end
    
end

