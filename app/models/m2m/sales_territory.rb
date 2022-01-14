# == Schema Information
#
# Table name: cspopup
#
#  fcpopkey         :char(20)         default("                    "), not null
#  fcpoptext        :varchar(80)      default(""), not null
#  fcpopval         :char(10)         default("          "), not null
#  fnorder          :integer          default(0), not null
#  fcpopacces       :char(1)          default(" "), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::SalesTerritory < M2m::CsPopup
  default_scope -> { where(:fcpopkey => 'SLCDPM.FCTERR') }
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
