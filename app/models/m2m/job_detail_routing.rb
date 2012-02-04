class M2m::JobDetailRouting < M2m::Base
  set_table_name 'jodrtg'
  
  has_one :work_center, :class_name => 'M2m::WorkCenter', :primary_key => 'fpro_id', :foreign_key => 'fcpro_id'
  
  scope :by_operation_number, :order => 'foperno'
  
  alias_attribute :operation_number, :foperno
  alias_attribute :quantity_complete, :fnqty_comp
  alias_attribute :percentage_complete, :fnpct_comp
  alias_attribute :quantity, :foperqty
  alias_attribute :operation_memo, :fopermemo
  alias_attribute :work_center_id, :fpro_id
  
  def start_date
    M2m::Constants.sanitize_date(self.fstrtdate)
  end
  
end

# == Schema Information
#
# Table name: jodrtg
#
#  fnlflushqty      :decimal(15, 5)  default(0.0), not null
#  fjobno           :string(10)      default(""), not null
#  foperno          :integer(4)      default(0), not null
#  factschdfn       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  factschdst       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fbominum         :string(4)       default(""), not null
#  fchngrates       :string(1)       default(""), not null
#  fcomp_date       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fcstat           :string(1)       default(""), not null
#  fstrtdate        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fddue_date       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fdescnum         :string(4)       default(""), not null
#  fdrel_date       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  felpstime        :decimal(8, 2)   default(0.0), not null
#  ffixcost         :decimal(17, 5)  default(0.0), not null
#  fflushed         :string(1)       default(""), not null
#  finumber         :string(3)       default(""), not null
#  flastlab         :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  flschedule       :boolean         default(FALSE), not null
#  fmovetime        :decimal(8, 2)   default(0.0), not null
#  fndelay          :integer(4)      default(0), not null
#  fndue_time       :integer(4)      default(0), not null
#  fneed_dt         :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fnnext_evt       :integer(4)      default(0), not null
#  fnpct_comp       :integer(4)      default(0), not null
#  fnqty_comp       :decimal(15, 5)  default(0.0), not null
#  fnqty_move       :decimal(15, 5)  default(0.0), not null
#  fnqty_togo       :decimal(15, 5)  default(0.0), not null
#  fnque_time       :integer(4)      default(0), not null
#  fnrel_time       :integer(4)      default(0), not null
#  fnshft           :integer(4)      default(0), not null
#  fnsh_date        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fnsh_time        :integer(4)      default(0), not null
#  fnstrttime       :integer(4)      default(0), not null
#  foperqty         :decimal(15, 5)  default(0.0), not null
#  foper_strt       :string(1)       default(""), not null
#  fothrcost        :decimal(17, 5)  default(0.0), not null
#  fpono            :string(6)       default(""), not null
#  fpoqty           :decimal(17, 5)  default(0.0), not null
#  fnretpoqty       :decimal(17, 5)  default(0.0), not null
#  flead_tim        :decimal(8, 2)   default(0.0), not null
#  flead_stim       :decimal(8, 2)   default(0.0), not null
#  fprod_tim        :decimal(8, 2)   default(0.0), not null
#  fprod_val        :decimal(17, 5)  default(0.0), not null
#  fpro_id          :string(7)       default(""), not null
#  fresponse        :string(1)       default(""), not null
#  fsetuptime       :decimal(7, 2)   default(0.0), not null
#  fsetup_tim       :decimal(8, 2)   default(0.0), not null
#  fsetup_val       :decimal(17, 5)  default(0.0), not null
#  fshipmt          :string(1)       default(""), not null
#  fsource          :string(1)       default(""), not null
#  fsplit           :boolean         default(FALSE), not null
#  fsubcont         :string(1)       default(""), not null
#  ftduedate        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  ftfnshdate       :string(15)      default(""), not null
#  ftfnshtime       :integer(4)      default(0), not null
#  ftimetogo        :decimal(10, 2)  default(0.0), not null
#  ftot_app         :decimal(15, 5)  default(0.0), not null
#  ftot_rew         :decimal(15, 5)  default(0.0), not null
#  ftot_scr         :decimal(15, 5)  default(0.0), not null
#  ftquetime        :integer(4)      default(0), not null
#  ftreldate        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  ftstrtdate       :string(15)      default(""), not null
#  ftstrttime       :integer(4)      default(0), not null
#  fulabcost        :decimal(17, 5)  default(0.0), not null
#  fuovrhdcos       :decimal(17, 5)  default(0.0), not null
#  fuprodtime       :decimal(16, 10) default(0.0), not null
#  fusubcost        :decimal(17, 5)  default(0.0), not null
#  fvendno          :string(6)       default(""), not null
#  fllotreqd        :boolean         default(FALSE), not null
#  fcschdpct        :string(1)       default(""), not null
#  flfreeze         :boolean         default(FALSE), not null
#  fnsimulops       :integer(4)      default(0), not null
#  fccharcode       :string(10)      default(""), not null
#  fdplanstdt       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fopermemo        :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  flsaveprec       :boolean         default(FALSE), not null
#  flusesetup       :boolean         default(FALSE), not null
#  fndbrmod         :integer(4)      default(0), not null
#  fnlatestrt       :integer(4)      default(0), not null
#  fnmachine        :integer(4)      default(0), not null
#  fcfreezetype     :string(15)      default(""), not null
#  fcmachineuse     :string(100)     default(""), not null
#  fcsyncmisc       :string(20)      default(""), not null
#  UseBuffer        :boolean         default(FALSE), not null
#  NextBuffOp       :integer(4)      default(0), not null
#  BufferStrt       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  BufferEnd        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  ArriveTime       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  flBFLabor        :boolean         default(FALSE), not null
#  CycleUnits       :decimal(13, 3)  default(0.0), not null
#  UnitSize         :decimal(13, 3)  default(0.0), not null
#

