# == Schema Information
#
# Table name: csarcv
#
#  faraccno         :string(25)       default(""), not null
#  fccurrex         :string(25)       default(""), not null
#  fcperiod         :integer          default(0), not null
#  fdisctrinv       :boolean          default(FALSE), not null
#  fdueoffset       :integer          default(0), not null
#  fexptax          :string(1)        default(""), not null
#  ffindate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ffinrate         :decimal(5, 1)    default(0.0), not null
#  fgladjust        :string(25)       default(""), not null
#  fglcashact       :string(25)       default(""), not null
#  fgldiscnt        :string(25)       default(""), not null
#  fglfinchge       :string(25)       default(""), not null
#  fglfreight       :string(25)       default(""), not null
#  fglsales         :string(25)       default(""), not null
#  finsomemo        :boolean          default(FALSE), not null
#  flconfirm        :boolean          default(FALSE), not null
#  fmarkup          :decimal(8, 3)    default(0.0), not null
#  fcfyear          :string(20)       default(""), not null
#  fmthno           :integer          default(0), not null
#  fnover1          :integer          default(0), not null
#  fnover2          :integer          default(0), not null
#  fnover3          :integer          default(0), not null
#  fnover4          :integer          default(0), not null
#  fprtcomp         :string(1)        default(""), not null
#  fupsno           :string(15)       default(""), not null
#  fccustcred       :string(25)       default(""), not null
#  ftaxfrt          :boolean          default(FALSE), not null
#  flnewarfct       :boolean          default(FALSE), not null
#  fdvatdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fltaxdisct       :boolean          default(FALSE), not null
#  flvrpost         :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  finvmemo         :text             default(""), not null
#  fglunrev         :string(25)       default(""), not null
#  flunrev          :boolean          default(FALSE), not null
#  flaskfirst       :boolean          default(FALSE), not null
#  fcexppath        :string(254)      default(""), not null
#  fldiscontax      :boolean          default(TRUE), not null
#  fldisconfrt      :boolean          default(TRUE), not null
#

class M2m::AccountsReceivableSetup < M2m::Base
  self.table_name = 'csarcv'
  
  def self.customer_credit
    @customer_credit ||= first.fccustcred.strip
  end
  def self.receivables
    @receivables ||= first.faraccno.strip
  end
  def self.adjustment
    @adjustment ||= first.fgladjust.strip
  end
end
