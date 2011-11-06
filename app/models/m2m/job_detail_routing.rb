class M2m::JobDetailRouting < M2m::Base
  set_table_name 'jodrtg'
  
  has_one :work_center, :class_name => 'M2m::WorkCenter', :primary_key => 'fpro_id', :foreign_key => 'fcpro_id'
  
  named_scope :by_operation_number, :order => 'foperno'
  
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
#  fnlflushqty      :decimal(15, 5)  not null
#  fjobno           :string(10)      not null
#  foperno          :integer         not null
#  factschdfn       :datetime        not null
#  factschdst       :datetime        not null
#  fbominum         :string(4)       not null
#  fchngrates       :string(1)       not null
#  fcomp_date       :datetime        not null
#  fcstat           :string(1)       not null
#  fstrtdate        :datetime        not null
#  fddue_date       :datetime        not null
#  fdescnum         :string(4)       not null
#  fdrel_date       :datetime        not null
#  felpstime        :decimal(8, 2)   not null
#  ffixcost         :decimal(17, 5)  not null
#  fflushed         :string(1)       not null
#  finumber         :string(3)       not null
#  flastlab         :datetime        not null
#  flschedule       :boolean         not null
#  fmovetime        :decimal(8, 2)   not null
#  fndelay          :integer         not null
#  fndue_time       :integer         not null
#  fneed_dt         :datetime        not null
#  fnnext_evt       :integer         not null
#  fnpct_comp       :integer         not null
#  fnqty_comp       :decimal(15, 5)  not null
#  fnqty_move       :decimal(15, 5)  not null
#  fnqty_togo       :decimal(15, 5)  not null
#  fnque_time       :integer         not null
#  fnrel_time       :integer         not null
#  fnshft           :integer         not null
#  fnsh_date        :datetime        not null
#  fnsh_time        :integer         not null
#  fnstrttime       :integer         not null
#  foperqty         :decimal(15, 5)  not null
#  foper_strt       :string(1)       not null
#  fothrcost        :decimal(17, 5)  not null
#  fpono            :string(6)       not null
#  fpoqty           :decimal(17, 5)  not null
#  fnretpoqty       :decimal(17, 5)  not null
#  flead_tim        :decimal(8, 2)   not null
#  flead_stim       :decimal(8, 2)   not null
#  fprod_tim        :decimal(8, 2)   not null
#  fprod_val        :decimal(17, 5)  not null
#  fpro_id          :string(7)       not null
#  fresponse        :string(1)       not null
#  fsetuptime       :decimal(7, 2)   not null
#  fsetup_tim       :decimal(8, 2)   not null
#  fsetup_val       :decimal(17, 5)  not null
#  fshipmt          :string(1)       not null
#  fsource          :string(1)       not null
#  fsplit           :boolean         not null
#  fsubcont         :string(1)       not null
#  ftduedate        :datetime        not null
#  ftfnshdate       :string(15)      not null
#  ftfnshtime       :integer         not null
#  ftimetogo        :decimal(10, 2)  not null
#  ftot_app         :decimal(15, 5)  not null
#  ftot_rew         :decimal(15, 5)  not null
#  ftot_scr         :decimal(15, 5)  not null
#  ftquetime        :integer         not null
#  ftreldate        :datetime        not null
#  ftstrtdate       :string(15)      not null
#  ftstrttime       :integer         not null
#  fulabcost        :decimal(17, 5)  not null
#  fuovrhdcos       :decimal(17, 5)  not null
#  fuprodtime       :decimal(16, 10) not null
#  fusubcost        :decimal(17, 5)  not null
#  fvendno          :string(6)       not null
#  fllotreqd        :boolean         not null
#  fcschdpct        :string(1)       not null
#  flfreeze         :boolean         not null
#  fnsimulops       :integer         not null
#  fccharcode       :string(10)      not null
#  fdplanstdt       :datetime        not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fopermemo        :text            default(" "), not null
#  fac              :string(20)      not null
#  flsaveprec       :boolean         default(FALSE), not null
#  flusesetup       :boolean         default(FALSE), not null
#  fndbrmod         :integer         default(0), not null
#  fnlatestrt       :integer         default(0), not null
#  fnmachine        :integer         default(0), not null
#  fcfreezetype     :string(15)      not null
#  fcmachineuse     :string(100)     not null
#  fcsyncmisc       :string(20)      not null
#

