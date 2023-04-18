# == Schema Information
#
# Table name: jomast
#
#  fjobno           :varchar(20)      default(""), not null
#  fpartno          :char(25)         default("                         "), not null
#  fpartrev         :char(3)          default("   "), not null
#  fsono            :varchar(10)      default(""), not null
#  fstatus          :char(10)         default("          "), not null
#  factschdfn       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  factschdst       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fact_rel         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fassy_comp       :integer          default(0), not null
#  fassy_req        :integer          default(0), not null
#  fbilljob         :char(8)          default("        "), not null
#  fbominum         :char(4)          default("    "), not null
#  fbomrec          :integer          default(0), not null
#  fcas_bom         :boolean          default(FALSE), not null
#  fckeyfield       :char(20)         default("                    "), not null
#  fcompany         :varchar(35)      default(""), not null
#  fcomp_schl       :boolean          default(FALSE), not null
#  fconfirm         :boolean          default(FALSE), not null
#  fcus_id          :char(6)          default("      "), not null
#  fdduedtime       :integer          default(0), not null
#  fddue_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdesc            :boolean          default(FALSE), not null
#  fdescript        :varchar(70)      default(""), not null
#  fdet_bom         :boolean          default(FALSE), not null
#  fdet_rtg         :boolean          default(FALSE), not null
#  fdstart          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdfnshdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffst_job         :boolean          default(FALSE), not null
#  fglacct          :char(25)         default("                         "), not null
#  fhold_by         :char(23)         default("                       "), not null
#  fhold_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fitems           :integer          default(0), not null
#  fitype           :char(1)          default(" "), not null
#  fjob_name        :varchar(86)      default(""), not null
#  fkey             :char(6)          default("      "), not null
#  flastlab         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fmatlpcnt        :integer          default(0), not null
#  fmeasure         :char(3)          default("   "), not null
#  fmethod          :char(1)          default(" "), not null
#  fmultiple        :boolean          default(FALSE), not null
#  fnassy_com       :integer          default(0), not null
#  fnassy_req       :integer          default(0), not null
#  fnfnshtime       :integer          default(0), not null
#  fnontime         :integer          default(0), not null
#  fnpct_comp       :decimal(6, 1)    default(0.0), not null
#  fnpct_idle       :decimal(6, 1)    default(0.0), not null
#  fnrel_time       :integer          default(0), not null
#  fnshft           :integer          default(0), not null
#  fopen_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpartdesc        :varchar(40)      default(""), not null
#  fpick_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpick_st         :boolean          default(FALSE), not null
#  fpo_comp         :char(1)          default(" "), not null
#  ftrave_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftrave_st        :boolean          default(FALSE), not null
#  fpriority        :char(11)         default("           "), not null
#  fprocessby       :char(12)         default("            "), not null
#  fprodcl          :varchar(4)       default(""), not null
#  fpro_plan        :boolean          default(FALSE), not null
#  fquantity        :decimal(15, 5)   default(0.0), not null
#  frel_dt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fremtime         :integer          default(0), not null
#  fresponse        :char(1)          default(" "), not null
#  fresu_by         :char(19)         default("                   "), not null
#  fresu_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frouting         :decimal(17, 5)   default(0.0), not null
#  fr_dt            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fr_rev           :char(2)          default("  "), not null
#  fr_type          :char(1)          default(" "), not null
#  fschbefjob       :varchar(20)      default(""), not null
#  fschdflag        :char(1)          default(" "), not null
#  fschdprior       :char(1)          default(" "), not null
#  fschresdt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fsign_off        :boolean          default(FALSE), not null
#  fsplit           :boolean          default(FALSE), not null
#  fsplitfrom       :varchar(20)      default(""), not null
#  fsplitinfo       :char(12)         default("            "), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fstarted         :boolean          default(FALSE), not null
#  fstrt_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fstrt_time       :integer          default(0), not null
#  fsub_from        :varchar(20)      default(""), not null
#  fsub_rel         :boolean          default(FALSE), not null
#  fsummary         :boolean          default(FALSE), not null
#  ftduedate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftfnshdate       :char(15)         default("               "), not null
#  ftfnshtime       :integer          default(0), not null
#  ftot_assy        :integer          default(0), not null
#  ftreldt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftschresdt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftstrtdate       :char(15)         default("               "), not null
#  ftstrttime       :integer          default(0), not null
#  ftype            :char(1)          default(" "), not null
#  fcusrchr1        :char(20)         default("                    "), not null
#  fcusrchr2        :varchar(40)      default(""), not null
#  fcusrchr3        :varchar(40)      default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnlastopno       :integer          default(0), not null
#  fcdncfile        :varchar(80)      default(""), not null
#  fccadfile1       :varchar(250)     default(""), not null
#  fccadfile2       :varchar(250)     default(""), not null
#  fccadfile3       :varchar(250)     default(""), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :char(1)          default(" "), not null
#  flresync         :boolean          default(FALSE), not null
#  fdorgduedt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flquick          :boolean          default(FALSE), not null
#  flfreeze         :boolean          default(FALSE), not null
#  flchgpnd         :boolean          default(FALSE), not null
#  fllasteco        :char(25)         default("                         "), not null
#  flisapl          :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fjob_mem         :varchar_max(2147 default(""), not null
#  fmusermemo       :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  idono            :char(10)         default("          ")
#  sfac             :char(20)         default("                    ")
#  fcudrev          :char(3)          default("   "), not null
#  fdmndrank        :integer          default(0), not null
#  fndbrmod         :integer          default(0), not null
#  fnrouteno        :integer          default(0), not null
#  flplanfreeze     :boolean          default(FALSE), not null
#  fcsyncmisc       :char(20)         default("                    "), not null
#  UseBuffer        :boolean          default(FALSE), not null
#  BufferStrt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  BufferEnd        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  DemandCat        :char(1)          default(" "), not null
#  createddate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ModDate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fYield           :decimal(15, 5)   default(0.0), not null
#  fSetYield        :decimal(8, 2)    default(0.0), not null
#  fcrmano          :char(25)         default("                         "), not null
#  Firmed           :boolean          default(FALSE), not null
#

class M2m::Job < M2m::Base
  self.table_name = 'jomast'
  
  has_many :detail_routings, :class_name => 'M2m::JobDetailRouting', :foreign_key => :fjobno, :primary_key => :fjobno
  has_many :items, :class_name => 'M2m::JobItem', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  belongs_to_item :fpartno, :fpartrev
  belongs_to :parent_job, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno
  has_many :sub_jobs, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno

  scope :for_item, -> (item) {
    where :fpartno => item.try(:part_number), :fpartrev => item.try(:revision)
  }
  scope :with_job_number, -> (jobno) {
    where :fjobno => jobno
  }
  scope :released, -> { where(:fstatus => M2m::Status.released.name) }
  scope :status_open, -> { where([ 'jomast.fstatus in (?)', [M2m::Status.open.name, M2m::Status.released.name, M2m::Status.completed.name] ]) }
  def self.status(statuses)
    where ['jomast.fstatus in (?)', statuses ] 
  end
  scope :by_date_desc, -> { order('jomast.fhold_dt desc') }
  scope :customers, -> (customers) {
    customer_numbers = customers.map(&:customer_number)
    where [ 'jomast.fcus_id in (?)', customer_numbers ]
  }
  scope :released_since, -> (date) {
    date = DateParser.parse(date) if date.is_a?(String)
    where [ 'jomast.fact_rel >= ?', date ]
  }
  scope :by_part_number, -> { order(:fpartno) }
  
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
