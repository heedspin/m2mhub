# == Schema Information
#
# Table name: intran
#
#  fdate            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpartno          :string(25)       default(""), not null
#  fcpartrev        :string(3)        default(""), not null
#  ftype            :string(1)        default(""), not null
#  faccno           :string(25)       default(""), not null
#  fcode            :string(4)        default(""), not null
#  fcost            :decimal(17, 5)   default(0.0), not null
#  ffrombin         :string(14)       default(""), not null
#  ffromexpdt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffromjob         :string(10)       default(""), not null
#  ffromloc         :string(14)       default(""), not null
#  ffromlot         :string(20)       default(""), not null
#  finspect         :string(3)        default(""), not null
#  flabor           :decimal(17, 5)   default(0.0), not null
#  fmatl            :decimal(17, 5)   default(0.0), not null
#  fnumber          :integer          default(0), not null
#  fovrhd           :decimal(17, 5)   default(0.0), not null
#  fqty             :decimal(15, 5)   default(0.0), not null
#  ftobin           :string(14)       default(""), not null
#  ftoexpdt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftojob           :string(10)       default(""), not null
#  ftoloc           :string(14)       default(""), not null
#  ftolot           :string(20)       default(""), not null
#  ftoso            :string(12)       default(""), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnnewonhd        :decimal(17, 5)   default(0.0), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fcomment         :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  ffromfac         :string(20)       default(""), not null
#  ftofac           :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
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
#  fuserinfo        :string(10)       default(""), not null
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
  scope :by_time_desc, -> { order('[intran].[fctime_ts] desc') }
  scope :outgoing, -> { where(['[intran].[ftype] in (?) and intran.fqty < 0', M2m::InventoryTransactionType.outgoing.map(&:key) ]) }
  scope :incoming, -> { where(['[intran].[ftype] in (?) and intran.fqty > 0', M2m::InventoryTransactionType.all_receipts.map(&:key) ]) }
  scope :to_sales, -> { where('[intran].[ftoso] != \'\'') }
  scope :between, -> (from_date, to_date) {
    where [ '[intran].[fctime_ts] >= ? and [intran].[fctime_ts] < ?', from_date, to_date ]
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

  def self.to_or_from(job)
    where ['[intran].[ftojob] = ? or [intran].[ffromjob] = ?', job.job_number, job.job_number]
  end

  def type_transfer?
    self.ftype == 'T'
  end

  def type_incoming?
    self.ftype == 'I'
  end
  
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
    @job ||= M2m::Job.job_number(self.job_number).first
  end

  def labor_cost
    self.quantity.abs * self.flabor
  end
  def overhead_cost
    self.quantity.abs * self.fovrhd
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
