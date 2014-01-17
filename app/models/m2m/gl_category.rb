# == Schema Information
#
# Table name: glhead
#
#  fcacctnum        :string(25)       default(""), not null
#  fcclass          :string(1)        default(""), not null
#  fccode           :string(1)        default(""), not null
#  fcdescr          :string(40)       default(""), not null
#  fcformat         :string(35)       default(""), not null
#  flconsol         :boolean          default(FALSE), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#

class M2m::GlCategory < M2m::Base
  self.table_name = 'glhead'
  def description
    self.fcdescr.strip.titleize
  end
end
