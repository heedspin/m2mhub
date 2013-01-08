# == Schema Information
#
# Table name: cspopup
#
#  fcpopkey         :string(20)      default(""), not null
#  fcpoptext        :string(80)      default(""), not null
#  fcpopval         :string(10)      default(""), not null
#  fnorder          :integer(4)      default(0), not null
#  fcpopacces       :string(1)       default(""), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

class M2m::SalesTerritory < M2m::CsPopup
  default_scope where(:fcpopkey => 'SLCDPM.FCTERR')
  def name
    self.text
  end
  def self.cached_lookup(territory_code)
    if cs_popup = M2m::CsPopup.cached_lookup('SLCDPM.FCTERR', territory_code)
      cs_popup.becomes(M2m::SalesTerritory)
    else
      nil
    end
  end
end
