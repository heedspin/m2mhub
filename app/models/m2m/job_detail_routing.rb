# == Schema Information
#
# Table name: jodrtg
#
#  fnlflushqty      :decimal(15, 5)   default(0.0), not null
#  fjobno           :varchar(20)      default(""), not null
#  foperno          :integer          default(0), not null
#  factschdfn       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  factschdst       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fbominum         :char(4)          default("    "), not null
#  fchngrates       :char(1)          default(" "), not null
#  fcomp_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcstat           :char(1)          default(" "), not null
#  fstrtdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fddue_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdescnum         :char(4)          default("    "), not null
#  fdrel_date       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  felpstime        :decimal(8, 2)    default(0.0), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  fflushed         :char(1)          default(" "), not null
#  finumber         :char(3)          default("   "), not null
#  flastlab         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flschedule       :boolean          default(FALSE), not null
#  fmovetime        :decimal(8, 2)    default(0.0), not null
#  fndelay          :integer          default(0), not null
#  fndue_time       :integer          default(0), not null
#  fneed_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnnext_evt       :integer          default(0), not null
#  fnpct_comp       :integer          default(0), not null
#  fnqty_comp       :decimal(15, 5)   default(0.0), not null
#  fnqty_move       :decimal(15, 5)   default(0.0), not null
#  fnqty_togo       :decimal(15, 5)   default(0.0), not null
#  fnque_time       :integer          default(0), not null
#  fnrel_time       :integer          default(0), not null
#  fnshft           :integer          default(0), not null
#  fnsh_date        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnsh_time        :integer          default(0), not null
#  fnstrttime       :integer          default(0), not null
#  foperqty         :decimal(15, 5)   default(0.0), not null
#  foper_strt       :char(1)          default(" "), not null
#  fothrcost        :decimal(17, 5)   default(0.0), not null
#  fpono            :varchar(10)      default(""), not null
#  fpoqty           :decimal(17, 5)   default(0.0), not null
#  fnretpoqty       :decimal(17, 5)   default(0.0), not null
#  flead_tim        :decimal(8, 2)    default(0.0), not null
#  flead_stim       :decimal(8, 2)    default(0.0), not null
#  fprod_tim        :decimal(8, 2)    default(0.0), not null
#  fprod_val        :decimal(17, 5)   default(0.0), not null
#  fpro_id          :char(7)          default("       "), not null
#  fresponse        :char(1)          default(" "), not null
#  fsetuptime       :decimal(7, 2)    default(0.0), not null
#  fsetup_tim       :decimal(8, 2)    default(0.0), not null
#  fsetup_val       :decimal(17, 5)   default(0.0), not null
#  fshipmt          :char(1)          default(" "), not null
#  fsource          :char(1)          default(" "), not null
#  fsplit           :boolean          default(FALSE), not null
#  fsubcont         :char(1)          default(" "), not null
#  ftduedate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftfnshdate       :char(15)         default("               "), not null
#  ftfnshtime       :integer          default(0), not null
#  ftimetogo        :decimal(10, 2)   default(0.0), not null
#  ftot_app         :decimal(15, 5)   default(0.0), not null
#  ftot_rew         :decimal(15, 5)   default(0.0), not null
#  ftot_scr         :decimal(15, 5)   default(0.0), not null
#  ftquetime        :integer          default(0), not null
#  ftreldate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftstrtdate       :char(15)         default("               "), not null
#  ftstrttime       :integer          default(0), not null
#  fulabcost        :decimal(17, 5)   default(0.0), not null
#  fuovrhdcos       :decimal(17, 5)   default(0.0), not null
#  fuprodtime       :decimal(16, 10)  default(0.0), not null
#  fusubcost        :decimal(17, 5)   default(0.0), not null
#  fvendno          :char(6)          default("      "), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fcschdpct        :char(1)          default(" "), not null
#  flfreeze         :boolean          default(FALSE), not null
#  fnsimulops       :integer          default(0), not null
#  fccharcode       :char(10)         default("          "), not null
#  fdplanstdt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fopermemo        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  flsaveprec       :boolean          default(FALSE), not null
#  flusesetup       :boolean          default(FALSE), not null
#  fndbrmod         :integer          default(0), not null
#  fnlatestrt       :integer          default(0), not null
#  fnmachine        :integer          default(0), not null
#  fcfreezetype     :char(15)         default("               "), not null
#  fcmachineuse     :char(100)        default("                                                                                                    "), not null
#  fcsyncmisc       :char(20)         default("                    "), not null
#  UseBuffer        :boolean          default(FALSE), not null
#  NextBuffOp       :integer          default(0), not null
#  BufferStrt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  BufferEnd        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ArriveTime       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flBFLabor        :boolean          default(FALSE), not null
#  CycleUnits       :decimal(13, 3)   default(0.0), not null
#  UnitSize         :decimal(13, 3)   default(0.0), not null
#  LateStrtDt       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::JobDetailRouting < M2m::Base
  self.table_name = 'jodrtg'
  
  has_one :work_center, :class_name => 'M2m::WorkCenter', :primary_key => 'fpro_id', :foreign_key => 'fcpro_id'
  
  scope :by_operation_number, -> { order(:foperno) }

  alias_attribute :operation_number, :foperno
  alias_attribute :quantity_complete, :fnqty_comp
  alias_attribute :percentage_complete, :fnpct_comp
  alias_attribute :quantity, :foperqty
  alias_attribute :operation_memo, :fopermemo
  alias_attribute :work_center_id, :fpro_id
  
  def start_date
    M2m::Constants.sanitize_date(self.fstrtdate)
  end
  
  def cached_work_center
    # self.work_center = will cause double loading of wc. 
    result = M2m::WorkCenter.cached_lookup(self.work_center_id)
    self.work_center_id = result.id
    result
  end
end
