# == Schema Information
#
# Table name: LADETAIL
#
#  fcearncode       :string(4)        default(""), not null
#  fchrglab         :decimal(10, 4)   default(0.0), not null
#  fcmpl            :boolean          default(FALSE), not null
#  fcode1           :string(1)        default(""), not null
#  fcode2           :string(1)        default(""), not null
#  fcompqty         :decimal(15, 5)   default(0.0), not null
#  fdate            :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fedatetime       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
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
#  fsdatetime       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
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
#  identity_column  :integer          not null
#  timestamp_column :binary
#  fac              :string(20)       default("")
#  fcdept           :string(2)        default(""), not null
#

class M2m::DailyLaborDetail < M2m::Base
	self.table_name = 'LADETAIL'

  alias_attribute :job_number, :fjobno
	alias_attribute :overhead_cost, :ftotocost
	alias_attribute :labor_cost, :ftotpcost

	def setup?
		self.fcode1 == 'S'
	end
	def production?
		self.fcode1 == 'P'
	end

	def self.attach(map)
    self.where(:fjobno => map.keys).each { |d| map[d.job_number].add_cached_labor_detail(d) }
	end
end
