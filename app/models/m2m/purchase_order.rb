# == Schema Information
#
# Table name: pomast
#
#  fcompany          :varchar(35)      default(""), not null
#  fcshipto          :char(8)          default("        "), not null
#  forddate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpono             :varchar(10)      default(""), not null, primary key
#  fstatus           :char(20)         default("                    "), not null
#  fvendno           :char(6)          default("      "), not null
#  fbuyer            :char(3)          default("   "), not null
#  fchangeby         :char(25)         default("                         "), not null
#  fcngdate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fconfirm          :char(19)         default("                   "), not null
#  fcontact          :char(20)         default("                    "), not null
#  fcfname           :char(15)         default("               "), not null
#  fcreate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffob              :char(20)         default("                    "), not null
#  fmethod           :char(1)          default(" "), not null
#  foldstatus        :char(20)         default("                    "), not null
#  fordrevdt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fordtot           :decimal(15, 5)   default(0.0), not null
#  fpayterm          :char(4)          default("    "), not null
#  fpaytype          :char(1)          default(" "), not null
#  fporev            :char(2)          default("  "), not null
#  fprint            :char(1)          default(" "), not null
#  freqdate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  freqsdt           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  freqsno           :varchar(10)      default(""), not null
#  frevtot           :decimal(15, 5)   default(0.0), not null
#  fsalestax         :decimal(7, 3)    default(0.0), not null
#  fshipvia          :char(20)         default("                    "), not null
#  ftax              :char(1)          default(" "), not null
#  fcsnaddrke        :varchar(6)       default(""), not null
#  fcsncity          :char(20)         default("                    "), not null
#  fcsnstate         :char(20)         default("                    "), not null
#  fcsnzip           :char(10)         default("          "), not null
#  fcsncountr        :char(25)         default("                         "), not null
#  fcsnphone         :char(20)         default("                    "), not null
#  fcsnfax           :char(20)         default("                    "), not null
#  fcshkey           :char(6)          default("      "), not null
#  fcshaddrke        :varchar(6)       default(""), not null
#  fcshcompan        :varchar(35)      default(""), not null
#  fcshcity          :char(20)         default("                    "), not null
#  fcshstate         :char(20)         default("                    "), not null
#  fcshzip           :char(10)         default("          "), not null
#  fcshcountr        :char(25)         default("                         "), not null
#  fcshphone         :char(20)         default("                    "), not null
#  fcshfax           :char(20)         default("                    "), not null
#  fnnextitem        :integer          default(0), not null
#  fautoclose        :char(1)          default(" "), not null
#  fcusrchr1         :char(20)         default("                    "), not null
#  fcusrchr2         :varchar(40)      default(""), not null
#  fcusrchr3         :varchar(40)      default(""), not null
#  fnusrqty1         :decimal(17, 5)   default(0.0), not null
#  fnusrcur1         :money            default(0.0), not null
#  fdusrdate1        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccurid           :char(3)          default("   "), not null
#  fcfactor          :decimal(22, 10)  default(0.0), not null
#  fdcurdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdeurodate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr         :decimal(17, 5)   default(0.0), not null
#  fctype            :char(1)          default(" "), not null
#  timestamp_column  :ss_timestamp
#  identity_column   :integer          not null
#  fmpaytype         :varchar_max(2147 default(""), not null
#  fmshstreet        :varchar_max(2147 default(""), not null
#  fmsnstreet        :varchar_max(2147 default(""), not null
#  fmusrmemo1        :varchar_max(2147 default(""), not null
#  fpoclosing        :varchar_max(2147 default(""), not null
#  freasoncng        :varchar_max(2147 default(""), not null
#  fndbrmod          :integer          default(0), not null
#  flpdate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  contactnum        :varchar(6)       default(""), not null
#  fac               :varchar(20)      default(""), not null
#  fhasshipableitems :boolean
#  ModifiedDate      :datetime
#

class M2m::PurchaseOrder < M2m::Base
  self.table_name = 'pomast'
  self.primary_key = 'fpono'
  
  has_many :items, :class_name => 'M2m::PurchaseOrderItem', :foreign_key => :fpono, :primary_key => :fpono  
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno
  has_many :receivers, :class_name => 'M2m::Receiver', :foreign_key => :fpono, :primary_key => :fpono
  has_many :inspection_tasks, :class_name => 'Quality::InspectionTask', :foreign_key => :purchase_order_number

  scope :status_open,      -> { where(:fstatus => M2m::PurchaseOrderStatus.open.name) }
  scope :status_closed,    -> { where(:fstatus => M2m::PurchaseOrderStatus.closed.name) }
  scope :status_cancelled, -> { where(:fstatus => M2m::PurchaseOrderStatus.cancelled.name) }
  scope :inventory, -> { includes(:items).where(:poitem => { :fcategory => 'INV     '}) }
  
  alias_attribute :vendor_name, :fcompany
  alias_attribute :change_date, :fcngdate
  alias_attribute :purchase_order_number, :fpono
  alias_attribute :order_date, :forddate
  alias_attribute :fob, :ffob
  alias_attribute :vendor_number, :fvendno

  def status
    M2m::PurchaseOrderStatus.find_by_m2mname(self.fstatus.strip)
  end

  def cancelled?
    self.status.try(:cancelled?)
  end
  
  def closed?
    self.status.try(:closed?)
  end

  def open?
    self.status.try(:open?)
  end
  
  def self.pad_purchase_order_number(number)
    "%06d" % number.to_i
  end
    
end

