# == Schema Information
#
# Table name: glhead
#
#  fcacctnum        :char(25)         default("                         "), not null
#  fcclass          :char(1)          default(" "), not null
#  fccode           :char(1)          default(" "), not null
#  fcdescr          :varchar(40)      default(""), not null
#  fcformat         :varchar(35)      default(""), not null
#  flconsol         :boolean          default(FALSE), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::GlCategory < M2m::Base
  self.table_name = 'glhead'
  def description
    self.fcdescr.strip.titleize
  end
end
