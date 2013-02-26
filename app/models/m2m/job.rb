# == Schema Information
#
# Table name: jomast
#
#  fjobno           :string(10)       default(""), not null
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  fsono            :string(6)        default(""), not null
#  fstatus          :string(10)       default(""), not null
#  factschdfn       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  factschdst       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fact_rel         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fassy_comp       :integer          default(0), not null
#  fassy_req        :integer          default(0), not null
#  fbilljob         :string(8)        default(""), not null
#  fbominum         :string(4)        default(""), not null
#  fbomrec          :integer          default(0), not null
#  fcas_bom         :boolean          default(FALSE), not null
#  fckeyfield       :string(20)       default(""), not null
#  fcompany         :string(35)       default(""), not null
#  fcomp_schl       :boolean          default(FALSE), not null
#  fconfirm         :boolean          default(FALSE), not null
#  fcus_id          :string(6)        default(""), not null
#  fdduedtime       :integer          default(0), not null
#  fddue_date       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdesc            :boolean          default(FALSE), not null
#  fdescript        :string(70)       default(""), not null
#  fdet_bom         :boolean          default(FALSE), not null
#  fdet_rtg         :boolean          default(FALSE), not null
#  fdstart          :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdfnshdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ffst_job         :boolean          default(FALSE), not null
#  fglacct          :string(25)       default(""), not null
#  fhold_by         :string(23)       default(""), not null
#  fhold_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fitems           :integer          default(0), not null
#  fitype           :string(1)        default(""), not null
#  fjob_name        :string(86)       default(""), not null
#  fkey             :string(6)        default(""), not null
#  flastlab         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmatlpcnt        :integer          default(0), not null
#  fmeasure         :string(3)        default(""), not null
#  fmethod          :string(1)        default(""), not null
#  fmultiple        :boolean          default(FALSE), not null
#  fnassy_com       :integer          default(0), not null
#  fnassy_req       :integer          default(0), not null
#  fnfnshtime       :integer          default(0), not null
#  fnontime         :integer          default(0), not null
#  fnpct_comp       :decimal(6, 1)    default(0.0), not null
#  fnpct_idle       :decimal(6, 1)    default(0.0), not null
#  fnrel_time       :integer          default(0), not null
#  fnshft           :integer          default(0), not null
#  fopen_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fpartdesc        :string(40)       default(""), not null
#  fpick_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fpick_st         :boolean          default(FALSE), not null
#  fpo_comp         :string(1)        default(""), not null
#  ftrave_dt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftrave_st        :boolean          default(FALSE), not null
#  fpriority        :string(11)       default(""), not null
#  fprocessby       :string(12)       default(""), not null
#  fprodcl          :string(2)        default(""), not null
#  fpro_plan        :boolean          default(FALSE), not null
#  fquantity        :decimal(15, 5)   default(0.0), not null
#  frel_dt          :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fremtime         :integer          default(0), not null
#  fresponse        :string(1)        default(""), not null
#  fresu_by         :string(19)       default(""), not null
#  fresu_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  frouting         :decimal(17, 5)   default(0.0), not null
#  fr_dt            :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fr_rev           :string(2)        default(""), not null
#  fr_type          :string(1)        default(""), not null
#  fschbefjob       :string(10)       default(""), not null
#  fschdflag        :string(1)        default(""), not null
#  fschdprior       :string(1)        default(""), not null
#  fschresdt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fsign_off        :boolean          default(FALSE), not null
#  fsplit           :boolean          default(FALSE), not null
#  fsplitfrom       :string(10)       default(""), not null
#  fsplitinfo       :string(12)       default(""), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fstarted         :boolean          default(FALSE), not null
#  fstrt_date       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fstrt_time       :integer          default(0), not null
#  fsub_from        :string(10)       default(""), not null
#  fsub_rel         :boolean          default(FALSE), not null
#  fsummary         :boolean          default(FALSE), not null
#  ftduedate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftfnshdate       :string(15)       default(""), not null
#  ftfnshtime       :integer          default(0), not null
#  ftot_assy        :integer          default(0), not null
#  ftreldt          :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftschresdt       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftstrtdate       :string(15)       default(""), not null
#  ftstrttime       :integer          default(0), not null
#  ftype            :string(1)        default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnlastopno       :integer          default(0), not null
#  fcdncfile        :string(80)       default(""), not null
#  fccadfile1       :string(250)      default(""), not null
#  fccadfile2       :string(250)      default(""), not null
#  fccadfile3       :string(250)      default(""), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :string(1)        default(""), not null
#  flresync         :boolean          default(FALSE), not null
#  fdorgduedt       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flquick          :boolean          default(FALSE), not null
#  flfreeze         :boolean          default(FALSE), not null
#  flchgpnd         :boolean          default(FALSE), not null
#  fllasteco        :string(25)       default(""), not null
#  flisapl          :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fjob_mem         :text             default(""), not null
#  fmusermemo       :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  idono            :string(10)       default("")
#  sfac             :string(20)       default("")
#  fcudrev          :string(3)        default(""), not null
#  fdmndrank        :integer          default(0), not null
#  fndbrmod         :integer          default(0), not null
#  fnrouteno        :integer          default(0), not null
#  flplanfreeze     :boolean          default(FALSE), not null
#  fcsyncmisc       :string(20)       default(""), not null
#  UseBuffer        :boolean          default(FALSE), not null
#  BufferStrt       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  BufferEnd        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  DemandCat        :string(1)        default(""), not null
#  createddate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ModDate          :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fYield           :decimal(15, 5)   default(0.0), not null
#  fSetYield        :decimal(8, 2)    default(0.0), not null
#  fcrmano          :string(25)       default(""), not null
#

class M2m::Job < M2m::Base
  set_table_name 'jomast'
  
  has_many :detail_routings, :class_name => 'M2m::JobDetailRouting', :foreign_key => :fjobno, :primary_key => :fjobno
  has_many :items, :class_name => 'M2m::JobItem', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  belongs_to_item :fpartno, :fpartrev
  belongs_to :parent_job, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno
  has_many :sub_jobs, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno

  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision }
    }
  }
  scope :with_job_number, lambda { |jobno|
    {
      :conditions => { :fjobno => jobno }
    }
  }
  scope :released, :conditions => { :fstatus => M2m::Status.released.name }
  scope :status_open, :conditions => [ 'jomast.fstatus in (?)', [M2m::Status.open.name, M2m::Status.released.name, M2m::Status.completed.name] ] 
  scope :by_date_desc, :order => 'jomast.fhold_dt desc'
  scope :customers, lambda { |customers|
    customer_numbers = customers.map(&:customer_number)
    {
      :conditions => [ 'jomast.fcus_id in (?)', customer_numbers ]
    }
  }
  scope :released_since, lambda { |date|
    date = Date.parse(date) if date.is_a?(String)
    {
      :conditions => [ 'jomast.fact_rel >= ?', date ]
    }
  }
  scope :by_part_number, :order => 'jobmast.fpartno'
  
  def status
    M2m::Status.find_by_name(self.fstatus)
  end
  
  def job_type
    M2m::JobType.find_by_key(self.type_code)
  end
  
  def internal_type
    M2m::JobInternalType.find_by_key(self.internal_type_code)
  end
  
  def status_date
    if self.status.released?
      self.release_date
    elsif self.status.open?
      self.open_date
    elsif (self.status.cancelled? or self.status.on_hold? or self.status.closed?)
      self.hold_date
    elsif self.status.completed?
      self.finish_date || self.last_labor_date
    else
      nil
    end
  end
  
  alias_attribute :job_number, :fjobno
  alias_date_attribute :release_date, :fact_rel
  alias_date_attribute :finish_date, :fdfnshdate
  alias_date_attribute :hold_date, :fhold_dt
  alias_date_attribute :last_labor_date, :flastlab
  alias_date_attribute :open_date, :fopen_dt
  alias_date_attribute :created_at, :fdstart
  alias_attribute :customer_number, :fcus_id
  alias_attribute :customer_name, :fcompany
  alias_attribute :internal_type_code, :fitype
  alias_attribute :type_code, :ftype
  alias_attribute :quantity, :fquantity
  alias_attribute :parent_job_number, :fschbefjob
  
  def customer
    @customer ||= M2m::Customer.with_customer_number(self.customer_number).first
  end
end
