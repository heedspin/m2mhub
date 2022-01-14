# == Schema Information
#
# Table name: intran
#
#  fdate            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpartno          :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  ftype            :char(1)          default(" "), not null
#  faccno           :char(25)         default("                         "), not null
#  fcode            :char(4)          default("    "), not null
#  fcost            :decimal(17, 5)   default(0.0), not null
#  ffrombin         :char(14)         default("              "), not null
#  ffromexpdt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffromjob         :varchar(20)      default(""), not null
#  ffromloc         :char(14)         default("              "), not null
#  ffromlot         :varchar(50)      default(""), not null
#  finspect         :char(3)          default("   "), not null
#  flabor           :decimal(17, 5)   default(0.0), not null
#  fmatl            :decimal(17, 5)   default(0.0), not null
#  fnumber          :integer          default(0), not null
#  fovrhd           :decimal(17, 5)   default(0.0), not null
#  fqty             :decimal(15, 5)   default(0.0), not null
#  ftobin           :char(14)         default("              "), not null
#  ftoexpdt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftojob           :varchar(20)      default(""), not null
#  ftoloc           :char(14)         default("              "), not null
#  ftolot           :varchar(50)      default(""), not null
#  ftoso            :varchar(16)      default(""), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnnewonhd        :decimal(17, 5)   default(0.0), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fcomment         :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  ffromfac         :char(20)         default("                    "), not null
#  ftofac           :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fiorigum         :integer          default(0), not null
#  fium1            :integer          default(0), not null
#  fium2            :integer          default(0), not null
#  fium3            :integer          default(0), not null
#  fium4            :integer          default(0), not null
#  fium5            :integer          default(0), not null
#  fiunitcnt        :integer          default(0), not null
#  fnorigqty        :decimal(17, 5)   default(0.0), not null
#  fnqty1           :decimal(17, 5)   default(0.0), not null
#  fnqty2           :decimal(17, 5)   default(0.0), not null
#  fnqty3           :decimal(17, 5)   default(0.0), not null
#  fnqty4           :decimal(17, 5)   default(0.0), not null
#  fnqty5           :decimal(17, 5)   default(0.0), not null
#  fuserinfo        :varchar(35)      default(""), not null
#  FCISSUEFROM      :varchar(10)      default(""), not null
#  FCSONO           :varchar(10)      default(""), not null
#  FINUMBER         :varchar(3)       default(""), not null
#  FRELEASE         :varchar(3)       default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::InventoryTransaction < M2m::Base
  self.table_name = 'intran'
  
  belongs_to_item :fpartno, :fcpartrev
  belongs_to :job, :class_name => 'M2m::Job', :foreign_key => :ftojob, :primary_key => :fjobno
  
  def transaction_type
    M2m::InventoryTransactionType.find_by_key(self.ftype)
  end
  
  alias_attribute :quantity, :fqty
  alias_attribute :date, :fdate
  alias_attribute :time, :fctime_ts
  alias_attribute :comment, :fcomment
  alias_attribute :from_job, :ffromjob
  alias_attribute :to_job, :ftojob
  alias_attribute :to_sales_order, :ftoso
  alias_attribute :from_bin, :ffrombin
  alias_attribute :to_bin, :ftobin
  alias_attribute :job_number, :ftojob
  scope :by_time, -> { order(:fctime_ts) }
  scope :by_time_desc, -> { order('intran.fctime_ts desc') }
  scope :outgoing, -> { where(['intran.ftype in (?) and intran.fqty < 0', M2m::InventoryTransactionType.outgoing.map(&:key) ]) }
  scope :incoming, -> { where(['intran.ftype in (?) and intran.fqty > 0', M2m::InventoryTransactionType.all_receipts.map(&:key) ]) }
  scope :to_sales, -> { where('intran.ftoso != \'\'') }
  scope :between, -> (from_date, to_date) {
    where [ 'intran.fctime_ts >= ? and intran.fctime_ts < ?', from_date, to_date ]
  }
  scope :part_number, -> (part_number) {
    where :fpartno => part_number
  }
  scope :revision, -> (revision) {
    where :fcpartrev => revision
  }
  scope :to_location, -> (location) {
    where :ftoloc => location
  }
  
  # "WHERE intran.ftoso = (sorels.fsono + sorels.finumber + sorels.frelease) " + ;

  def for_sales_order?
    self.to_sales_order.present?
  end
  
  def for_job?
    self.to_job.present?
  end  

  def sales_order_number
    @sales_order_number ||= self.to_sales_order[0..5]
  end
  
  def sales_order_release_id
    @sales_order_release_id ||= self.to_sales_order[6..8]
  end 

  def sales_order_release_number
    @sales_order_release_number ||= self.to_sales_order[9..11]
  end
  
  def sales_order
    @sales_order ||= M2m::SalesOrder.with_order_number(self.sales_order_number).first
  end
  
  def sales_order_release
    @sales_order_release ||= M2m::SalesOrderRelease.for_sales_order(self.sales_order_number).with_number(self.sales_order_release_id).first
  end
  
  def job
    @job ||= M2m::Job.with_job_number(self.job_number).first
  end
  
  def to_log
    tofrom = []
    tofrom.push "From Job: #{self.ffromjob.strip}" if self.from_job.present?
    tofrom.push "To Job: #{self.ftojob.strip}" if self.for_job?
    tofrom.push "To SO: #{self.ftoso.strip}" if self.for_sales_order?
    if self.transaction_type.transfers?
      tofrom.push "From #{self.from_bin.strip} to #{self.to_bin.strip}"
    end
    "#{id} #{self.date.to_s(:number_date)} #{self.transaction_type} #{self.quantity} #{tofrom.join(' ')}"
  end
  
end
