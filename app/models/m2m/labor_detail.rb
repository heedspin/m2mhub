# == Schema Information
#
# Table name: ladetail
#
#  fcearncode       :string(4)        default(""), not null
#  fchrglab         :decimal(10, 4)   default(0.0), not null
#  fcmpl            :boolean          default(FALSE), not null
#  fcode1           :string(1)        default(""), not null
#  fcode2           :string(1)        default(""), not null
#  fcompqty         :decimal(15, 5)   default(0.0), not null
#  fdate            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fedatetime       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fempno           :string(9)        default(""), not null
#  fendseries       :string(1)        default(""), not null
#  ferrbc           :integer          default(0), not null
#  ferrlist         :string(20)       default(""), not null
#  ff1              :boolean          default(FALSE), not null
#  findcost         :decimal(17, 5)   default(0.0), not null
#  fjoblocked       :boolean          default(FALSE), not null
#  fjobno           :string(10)       default(""), not null
#  flabtype         :string(1)        default(""), not null
#  fleadpersn       :boolean          default(FALSE), not null
#  fltrans          :boolean          default(FALSE), not null
#  foperno          :integer          default(0), not null
#  fovertime        :boolean          default(FALSE), not null
#  fovrate          :decimal(6, 2)    default(0.0), not null
#  fposted          :string(1)        default(""), not null
#  fpro_id          :string(7)        default(""), not null
#  fscrpqty         :decimal(15, 5)   default(0.0), not null
#  fsdatetime       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fseries          :integer          default(0), not null
#  fshift           :string(1)        default(""), not null
#  fstatus          :string(1)        default(""), not null
#  fsustate         :string(2)        default(""), not null
#  ftimecode        :string(1)        default(""), not null
#  ftotocost        :decimal(17, 5)   default(0.0), not null
#  ftotpcost        :decimal(17, 5)   default(0.0), not null
#  fwkclass         :string(4)        default(""), not null
#  fwkstate         :string(2)        default(""), not null
#  fnratefact       :decimal(12, 5)   default(0.0), not null
#  fnflatamnt       :decimal(17, 5)   default(0.0), not null
#  flchrtojob       :boolean          default(FALSE), not null
#  fccustom         :string(25)       default(""), not null
#  fcdept           :string(2)        default(""), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fac              :string(20)       default("")
#

class M2m::LaborDetail < M2m::Base
  self.table_name = 'ladetail'
  belongs_to :work_center, :class_name => 'M2m::WorkCenter', :foreign_key => :fpro_id, :primary_key => :fcpro_id
  belongs_to :employee, :class_name => 'M2m::Employee', :foreign_key => :fempno, :primary_key => :fempno
  
  alias_attribute :employee_number, :fempno
  alias_attribute :date, :fdate
  alias_attribute :start_time, :fsdatetime
  alias_attribute :end_time, :fedatetime
  
  scope :between, -> (start_date, end_date) {
    where ['[ladetail].[fdate] >= ? and [ladetail].[fdate] < ?', start_date, end_date.advance(:days => 1)]
  }
  scope :department, -> (department) {
    department = department.is_a?(M2m::Department) ? department : M2m::Department.find(department)
    joins(:employee).
    where(:prempl => { :fdept => department.department_number })
  }
  scope :by_date, -> { order(:fdate) }
end
