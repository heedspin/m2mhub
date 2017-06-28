# == Schema Information
#
# Table name: joitem
#
#  fjobno           :string(10)       default(""), not null
#  fitem            :string(3)        default(""), not null
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  fsono            :string(6)        default(""), not null
#  finumber         :string(3)        default(""), not null
#  fjob             :boolean          default(FALSE), not null
#  fkey             :string(3)        default(""), not null
#  fbook            :decimal(15, 5)   default(0.0), not null
#  fbqty            :decimal(15, 5)   default(0.0), not null
#  fcost_est        :decimal(17, 5)   default(0.0), not null
#  fcustpart        :string(25)       default(""), not null
#  fcustptrev       :string(3)        default(""), not null
#  fdelivery        :string(69)       default(""), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fgroup           :string(6)        default(""), not null
#  fhour_est        :decimal(9, 2)    default(0.0), not null
#  flshipdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fmeasure         :string(3)        default(""), not null
#  fmqty            :decimal(15, 5)   default(0.0), not null
#  fmultiple        :string(1)        default(""), not null
#  forderqty        :decimal(15, 5)   default(0.0), not null
#  fpartyld1        :decimal(8, 3)    default(0.0), not null
#  fprodcl          :string(2)        default(""), not null
#  frtgqty          :decimal(17, 5)   default(0.0), not null
#  fshipqty         :decimal(15, 5)   default(0.0), not null
#  fsource          :string(1)        default(""), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fstatus          :string(1)        default(""), not null
#  fulabcost1       :decimal(17, 5)   default(0.0), not null
#  fuprice          :decimal(17, 5)   default(0.0), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fdesc            :text             default(""), not null
#  fdescmemo        :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
#  fidoshpqty       :decimal(15, 5)   default(0.0)
#  fndbrmod         :integer          default(0), not null
#

class M2m::JobItem < M2m::Base
  self.table_name = 'joitem'
  belongs_to :job, :class_name => 'M2m::Job', :foreign_key => 'fjobno', :primary_key => 'fjobno'
  belongs_to_item :fpartno, :fpartrev
  alias_attribute :make_quantity, :fmqty
  alias_attribute :buy_quantity, :fbqty
  alias_attribute :stock_quantity, :fshipqty
end
