class M2m::CsPopup < M2m::Base
  set_table_name 'cspopup'
  scope :for_key, lambda { |key|
    {
      :conditions => { :fcpopkey => key }
    }
  }
  scope :with_code, lambda { |code|
    where(:fcpopval => code)
  }
  def code
    self.fcpopval.strip
  end
  def text
    self.fcpoptext.strip.titleize
  end
  
  @@cache = {}
  def self.cached_lookup(k, c)
    return nil unless k.present? and c.present?
    key = [k, c]
    @@cache[key] ||= M2m::CsPopup.for_key(k).with_code(c).first  
  end
end

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

