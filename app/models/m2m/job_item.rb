# == Schema Information
#
# Table name: joitem
#
#  fjobno           :varchar(20)      default(""), not null
#  fitem            :char(3)          default("   "), not null
#  fpartno          :char(25)         default("                         "), not null
#  fpartrev         :char(3)          default("   "), not null
#  fsono            :varchar(10)      default(""), not null
#  finumber         :char(3)          default("   "), not null
#  fjob             :boolean          default(FALSE), not null
#  fkey             :char(3)          default("   "), not null
#  fbook            :decimal(15, 5)   default(0.0), not null
#  fbqty            :decimal(15, 5)   default(0.0), not null
#  fcost_est        :decimal(17, 5)   default(0.0), not null
#  fcustpart        :char(25)         default("                         "), not null
#  fcustptrev       :char(3)          default("   "), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fgroup           :char(6)          default("      "), not null
#  fhour_est        :decimal(9, 2)    default(0.0), not null
#  flshipdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fmeasure         :char(3)          default("   "), not null
#  fmqty            :decimal(15, 5)   default(0.0), not null
#  fmultiple        :char(1)          default(" "), not null
#  forderqty        :decimal(15, 5)   default(0.0), not null
#  fpartyld1        :decimal(8, 3)    default(0.0), not null
#  fprodcl          :varchar(4)       default(""), not null
#  frtgqty          :decimal(17, 5)   default(0.0), not null
#  fshipqty         :decimal(15, 5)   default(0.0), not null
#  fsource          :char(1)          default(" "), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fstatus          :char(1)          default(" "), not null
#  fulabcost1       :decimal(17, 5)   default(0.0), not null
#  fuprice          :decimal(17, 5)   default(0.0), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fdesc            :varchar_max(2147 default(""), not null
#  fdescmemo        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fidoshpqty       :decimal(15, 5)   default(0.0)
#  fcudrev          :char(3)          default("   "), not null
#  fndbrmod         :integer          default(0), not null
#  fdelivery        :varchar_max(2147 default("")
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::JobItem < M2m::Base
  self.table_name = 'joitem'
  belongs_to :job, :class_name => 'M2m::Job', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  belongs_to_item :fpartno, :fpartrev
  alias_attribute :make_quantity, :fmqty
  alias_attribute :buy_quantity, :fbqty
  alias_attribute :stock_quantity, :fshipqty
end
