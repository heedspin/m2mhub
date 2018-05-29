# == Schema Information
#
# Table name: jomast
#
#  fjobno           :string(10)       default(""), not null
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  fsono            :string(6)        default(""), not null
#  fstatus          :string(10)       default(""), not null
#  factschdfn       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  factschdst       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fact_rel         :datetime         default(1900-01-01 00:00:00 UTC), not null
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
#  fddue_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdesc            :boolean          default(FALSE), not null
#  fdescript        :string(70)       default(""), not null
#  fdet_bom         :boolean          default(FALSE), not null
#  fdet_rtg         :boolean          default(FALSE), not null
#  fdstart          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdfnshdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffst_job         :boolean          default(FALSE), not null
#  fglacct          :string(25)       default(""), not null
#  fhold_by         :string(23)       default(""), not null
#  fhold_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fitems           :integer          default(0), not null
#  fitype           :string(1)        default(""), not null
#  fjob_name        :string(86)       default(""), not null
#  fkey             :string(6)        default(""), not null
#  flastlab         :datetime         default(1900-01-01 00:00:00 UTC), not null
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
#  fopen_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpartdesc        :string(40)       default(""), not null
#  fpick_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpick_st         :boolean          default(FALSE), not null
#  fpo_comp         :string(1)        default(""), not null
#  ftrave_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftrave_st        :boolean          default(FALSE), not null
#  fpriority        :string(11)       default(""), not null
#  fprocessby       :string(12)       default(""), not null
#  fprodcl          :string(2)        default(""), not null
#  fpro_plan        :boolean          default(FALSE), not null
#  fquantity        :decimal(15, 5)   default(0.0), not null
#  frel_dt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fremtime         :integer          default(0), not null
#  fresponse        :string(1)        default(""), not null
#  fresu_by         :string(19)       default(""), not null
#  fresu_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frouting         :decimal(17, 5)   default(0.0), not null
#  fr_dt            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fr_rev           :string(2)        default(""), not null
#  fr_type          :string(1)        default(""), not null
#  fschbefjob       :string(10)       default(""), not null
#  fschdflag        :string(1)        default(""), not null
#  fschdprior       :string(1)        default(""), not null
#  fschresdt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fsign_off        :boolean          default(FALSE), not null
#  fsplit           :boolean          default(FALSE), not null
#  fsplitfrom       :string(10)       default(""), not null
#  fsplitinfo       :string(12)       default(""), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fstarted         :boolean          default(FALSE), not null
#  fstrt_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fstrt_time       :integer          default(0), not null
#  fsub_from        :string(10)       default(""), not null
#  fsub_rel         :boolean          default(FALSE), not null
#  fsummary         :boolean          default(FALSE), not null
#  ftduedate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftfnshdate       :string(15)       default(""), not null
#  ftfnshtime       :integer          default(0), not null
#  ftot_assy        :integer          default(0), not null
#  ftreldt          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftschresdt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftstrtdate       :string(15)       default(""), not null
#  ftstrttime       :integer          default(0), not null
#  ftype            :string(1)        default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnlastopno       :integer          default(0), not null
#  fcdncfile        :string(80)       default(""), not null
#  fccadfile1       :string(250)      default(""), not null
#  fccadfile2       :string(250)      default(""), not null
#  fccadfile3       :string(250)      default(""), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :string(1)        default(""), not null
#  flresync         :boolean          default(FALSE), not null
#  fdorgduedt       :datetime         default(1900-01-01 00:00:00 UTC), not null
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
#  BufferStrt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  BufferEnd        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  DemandCat        :string(1)        default(""), not null
#  createddate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ModDate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fYield           :decimal(15, 5)   default(0.0), not null
#  fSetYield        :decimal(8, 2)    default(0.0), not null
#  fcrmano          :string(25)       default(""), not null
#

class M2m::Job < M2m::Base
  self.table_name = 'jomast'
  
  has_many :detail_routings, :class_name => 'M2m::JobDetailRouting', :foreign_key => :fjobno, :primary_key => :fjobno
  has_many :detail_boms, :class_name => 'M2m::JobDetailBom', :foreign_key => :fjobno, :primary_key => :fjobno
  has_many :labor_details, :class_name => 'M2m::DailyLaborDetail', :foreign_key => :fjobno, :primary_key => :fjobno
  has_many :items, :class_name => 'M2m::JobItem', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  belongs_to_item :fpartno, :fpartrev
  belongs_to :parent_job, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno
  has_many :sub_jobs, :class_name => 'M2m::Job', :foreign_key => :fschbefjob, :primary_key => :fjobno
  has_one :price_summary, :class_name => 'M2m::JobPriceSummary', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  has_many :purchase_order_items, :class_name => 'M2m::PurchaseOrderItem', :foreign_key => :fjokey, :primary_key => 'fjobno'
  has_many :receiver_items, :class_name => 'M2m::ReceiverItem', :foreign_key => :fjokey, :primary_key => 'fjobno'
  has_many :gl_production_postings, :class_name => 'M2m::GlProductionPosting', :foreign_key => :fjob_so, :primary_key => 'fjobno'
  has_many :to_inventory_transactions, :class_name => 'M2m::InventoryTransaction', :foreign_key => :ftojob, :primary_key => 'fjobno'

  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.try(:part_number), :fpartrev => item.try(:revision) }
    }
  }
  def self.job_number(jobno)
    where :fjobno => jobno
  end
  def self.job_family(jobno_prefix)
    where ['jomast.fjobno like ?', jobno_prefix + '-%']
  end
  def self.job_number_not(job_numbers)
    where ['jomast.fjobno not in (?)', job_numbers]
  end
  scope :released, :conditions => { :fstatus => M2m::Status.released.name }
  scope :status_open, :conditions => [ 'jomast.fstatus in (?)', [M2m::Status.open.name, M2m::Status.released.name, M2m::Status.completed.name] ] 
  def self.status(statuses)
    where ['jomast.fstatus in (?)', statuses ] 
  end
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

  def material_cost
    (self.item.try(:rolled_material_cost) || 0.0) * self.quantity
  end

  def labor_cost
    self.cached_detail_routings.sum(&:labor_cost)
  end

  def fixed_cost
    self.cached_detail_routings.sum(&:fixed_cost)
  end

  def sub_cost
    self.cached_detail_routings.sum(&:sub_cost)
  end

  def other_cost
    self.cached_detail_routings.sum(&:other_cost)
  end

  def overhead_cost
    self.cached_detail_routings.sum(&:overhead_cost)
  end

  def total_cost
    self.material_cost + self.labor_cost + self.fixed_cost + self.sub_cost + self.other_cost + self.overhead_cost
  end

  def actual_material_cost
    begin
      @actual_material_cost ||= self.gl_production_postings.inventory_issuances.part_numbers(self.cached_detail_boms.map(&:part_number)).sum(:fnamount)
    rescue ActiveRecord::StatementInvalid
      begin
        @actual_material_cost ||= self.gl_production_postings.inventory_issuances.part_numbers(self.cached_detail_boms.map(&:part_number)).sum(:fnamount)
      rescue
        raise $!
      end
    end
  end

  def actual_labor_cost
    if @actual_labor_cost.nil?
      transferred_in = self.cached_inventory_transactions.select(&:type_incoming?).sum(&:labor_cost)
      transferred_out = self.cached_inventory_transactions.select(&:type_transfer?).sum(&:labor_cost)
      @actual_labor_cost = self.cached_labor_details.sum(&:labor_cost) + transferred_in - transferred_out
    end
    @actual_labor_cost
  end

  def actual_sub_cost
    @actual_sub_cost ||= self.purchase_order_items.sum do |poi|
      poi.invoice_items.sum(&:price)
    end
  end

  def actual_overhead_cost
    if @actual_overhead_cost.nil?
      transferred_in = self.cached_inventory_transactions.select(&:type_incoming?).sum(&:overhead_cost)
      transferred_out = self.cached_inventory_transactions.select(&:type_transfer?).sum(&:overhead_cost)
      @actual_overhead_cost = self.cached_labor_details.sum(&:overhead_cost) + transferred_in - transferred_out
    end
    @actual_overhead_cost
  end

  def actual_cost
    self.actual_material_cost + self.actual_labor_cost + self.actual_sub_cost + self.actual_overhead_cost
  end

  def cached_detail_routings
    @cached_detail_routings ||= self.detail_routings.all
  end
  def add_cached_detail_routing(v)
    (@cached_detail_routings ||= []).push(v)
  end

  def cached_labor_details
    @cached_labor_details ||= self.labor_details.all
  end
  def add_cached_labor_detail(v)
    (@cached_labor_details ||= []).push(v)
  end

  def cached_detail_boms
    @cached_detail_boms ||= self.detail_boms.all
  end
  def add_cached_detail_bom(v)
    (@cached_detail_boms ||= []).push(v)
  end

  def cached_inventory_transactions
    @cached_inventory_transactions ||= M2m::InventoryTransaction.to_or_from(self).select([:ftype, :fqty, :flabor, :fovrhd]).all
  end
  # def add_cached_inventory_transactions(v)
  #   (@cached_inventory_transactions ||= []).push(v)
  # end
end
