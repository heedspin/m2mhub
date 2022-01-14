# == Schema Information
#
# Table name: csarcv
#
#  faraccno              :char(25)         default("                         "), not null
#  fccurrex              :char(25)         default("                         "), not null
#  fcperiod              :integer          default(0), not null
#  fdisctrinv            :boolean          default(FALSE), not null
#  fdueoffset            :integer          default(0), not null
#  fexptax               :char(1)          default(" "), not null
#  ffindate              :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ffinrate              :decimal(5, 1)    default(0.0), not null
#  fgladjust             :char(25)         default("                         "), not null
#  fglcashact            :char(25)         default("                         "), not null
#  fgldiscnt             :char(25)         default("                         "), not null
#  fglfinchge            :char(25)         default("                         "), not null
#  fglfreight            :char(25)         default("                         "), not null
#  fglsales              :char(25)         default("                         "), not null
#  finsomemo             :boolean          default(FALSE), not null
#  flconfirm             :boolean          default(FALSE), not null
#  fmarkup               :decimal(8, 3)    default(0.0), not null
#  fcfyear               :char(20)         default("                    "), not null
#  fmthno                :integer          default(0), not null
#  fnover1               :integer          default(0), not null
#  fnover2               :integer          default(0), not null
#  fnover3               :integer          default(0), not null
#  fnover4               :integer          default(0), not null
#  fprtcomp              :char(1)          default(" "), not null
#  fupsno                :char(15)         default("               "), not null
#  fccustcred            :char(25)         default("                         "), not null
#  ftaxfrt               :boolean          default(FALSE), not null
#  flnewarfct            :boolean          default(FALSE), not null
#  fdvatdate             :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fltaxdisct            :boolean          default(FALSE), not null
#  flvrpost              :boolean          default(FALSE), not null
#  timestamp_column      :ss_timestamp
#  identity_column       :integer          not null, primary key
#  finvmemo              :varchar_max(2147 default(""), not null
#  fglunrev              :char(25)         default("                         "), not null
#  flunrev               :boolean          default(FALSE), not null
#  flaskfirst            :boolean          default(FALSE), not null
#  fcexppath             :varchar(254)     default(""), not null
#  fldiscontax           :boolean          default(TRUE), not null
#  fldisconfrt           :boolean          default(TRUE), not null
#  flShowMultiShipperMsg :boolean          default(FALSE), not null
#  flshipdate            :boolean          default(FALSE), not null
#  CreatedDate           :datetime
#  ModifiedDate          :datetime
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
