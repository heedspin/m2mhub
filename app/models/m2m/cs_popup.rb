# == Schema Information
#
# Table name: cspopup
#
#  fcpopkey         :string(20)       default(""), not null
#  fcpoptext        :string(80)       default(""), not null
#  fcpopval         :string(10)       default(""), not null
#  fnorder          :integer          default(0), not null
#  fcpopacces       :string(1)        default(""), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#

class M2m::CsPopup < M2m::Base
  self.table_name = 'cspopup'
  scope :for_key, -> (key) {
    where :fcpopkey => key
  }
  scope :with_code, -> (code) {
    where(:fcpopval => code)
  }
  def code
    self.fcpopval.strip
  end
  def text
    self.fcpoptext.strip #.titleize
  end
  
  @@cache = {}
  def self.cached_lookup(k, c)
    return nil unless k.present? and c.present?
    key = [k, c]
    @@cache[key] ||= M2m::CsPopup.for_key(k).with_code(c).first  
  end
end
