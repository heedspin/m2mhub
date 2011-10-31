class M2m::Job < M2m::Base
  set_table_name 'jomast'

  named_scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision }
    }
  }

  named_scope :released, :conditions => { :fstatus => M2m::Status.released.name }
  
  named_scope :by_due_date_desc, :order => 'jomast.fddue_date desc'

  def status
    M2m::Status.find_by_name(self.fstatus)
  end
  
  alias_attribute :job_number, :fjobno
  
end
# == Schema Information
#
# Table name: jomast
#
#  fjobno           :string(10)      not null
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  fsono            :string(6)       not null
#  fstatus          :string(10)      not null
#  factschdfn       :datetime        not null
#  factschdst       :datetime        not null
#  fact_rel         :datetime        not null
#  fassy_comp       :integer         not null
#  fassy_req        :integer         not null
#  fbilljob         :string(8)       not null
#  fbominum         :string(4)       not null
#  fbomrec          :integer         not null
#  fcas_bom         :boolean         not null
#  fckeyfield       :string(20)      not null
#  fcompany         :string(35)      default(" "), not null
#  fcomp_schl       :boolean         not null
#  fconfirm         :boolean         not null
#  fcus_id          :string(6)       not null
#  fdduedtime       :integer         not null
#  fddue_date       :datetime        not null
#  fdesc            :boolean         not null
#  fdescript        :string(70)      default(" "), not null
#  fdet_bom         :boolean         not null
#  fdet_rtg         :boolean         not null
#  fdstart          :datetime        not null
#  fdfnshdate       :datetime        not null
#  ffst_job         :boolean         not null
#  fglacct          :string(25)      not null
#  fhold_by         :string(23)      not null
#  fhold_dt         :datetime        not null
#  fitems           :integer         not null
#  fitype           :string(1)       not null
#  fjob_name        :string(86)      default(" "), not null
#  fkey             :string(6)       not null
#  flastlab         :datetime        not null
#  fmatlpcnt        :integer         not null
#  fmeasure         :string(3)       not null
#  fmethod          :string(1)       not null
#  fmultiple        :boolean         not null
#  fnassy_com       :integer         not null
#  fnassy_req       :integer         not null
#  fnfnshtime       :integer         not null
#  fnontime         :integer         not null
#  fnpct_comp       :decimal(6, 1)   not null
#  fnpct_idle       :decimal(6, 1)   not null
#  fnrel_time       :integer         not null
#  fnshft           :integer         not null
#  fopen_dt         :datetime        not null
#  fpartdesc        :string(40)      default(" "), not null
#  fpick_dt         :datetime        not null
#  fpick_st         :boolean         not null
#  fpo_comp         :string(1)       not null
#  ftrave_dt        :datetime        not null
#  ftrave_st        :boolean         not null
#  fpriority        :string(11)      not null
#  fprocessby       :string(12)      not null
#  fprodcl          :string(2)       not null
#  fpro_plan        :boolean         not null
#  fquantity        :decimal(15, 5)  not null
#  frel_dt          :datetime        not null
#  fremtime         :integer         not null
#  fresponse        :string(1)       not null
#  fresu_by         :string(19)      not null
#  fresu_dt         :datetime        not null
#  frouting         :decimal(17, 5)  not null
#  fr_dt            :datetime        not null
#  fr_rev           :string(2)       not null
#  fr_type          :string(1)       not null
#  fschbefjob       :string(10)      not null
#  fschdflag        :string(1)       not null
#  fschdprior       :string(1)       not null
#  fschresdt        :datetime        not null
#  fsign_off        :boolean         not null
#  fsplit           :boolean         not null
#  fsplitfrom       :string(10)      not null
#  fsplitinfo       :string(12)      not null
#  fstandpart       :boolean         not null
#  fstarted         :boolean         not null
#  fstrt_date       :datetime        not null
#  fstrt_time       :integer         not null
#  fsub_from        :string(10)      not null
#  fsub_rel         :boolean         not null
#  fsummary         :boolean         not null
#  ftduedate        :datetime        not null
#  ftfnshdate       :string(15)      not null
#  ftfnshtime       :integer         not null
#  ftot_assy        :integer         not null
#  ftreldt          :datetime        not null
#  ftschresdt       :datetime        not null
#  ftstrtdate       :string(15)      not null
#  ftstrttime       :integer         not null
#  ftype            :string(1)       not null
#  fcusrchr1        :string(20)      not null
#  fcusrchr2        :string(40)      default(" "), not null
#  fcusrchr3        :string(40)      default(" "), not null
#  fnusrqty1        :decimal(15, 5)  not null
#  fnusrcur1        :decimal(17, 5)  not null
#  fdusrdate1       :datetime        not null
#  fnlastopno       :integer         not null
#  fcdncfile        :string(80)      default(" "), not null
#  fccadfile1       :string(250)     not null
#  fccadfile2       :string(250)     not null
#  fccadfile3       :string(250)     not null
#  fllotreqd        :boolean         not null
#  fclotext         :string(1)       not null
#  flresync         :boolean         not null
#  fdorgduedt       :datetime        not null
#  flquick          :boolean         not null
#  flfreeze         :boolean         not null
#  flchgpnd         :boolean         not null
#  fllasteco        :string(25)      not null
#  flisapl          :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fgimage          :binary          default("0x"), not null
#  fjob_mem         :text            default(" "), not null
#  fmusermemo       :text            default(" "), not null
#  fac              :string(20)      not null
#  idono            :string(10)
#  sfac             :string(20)
#  fcudrev          :string(3)       default(" "), not null
#  fdmndrank        :integer         default(0), not null
#  fndbrmod         :integer         default(0), not null
#  fnrouteno        :integer         not null
#  flplanfreeze     :boolean         not null
#  fcsyncmisc       :string(20)      not null
#

