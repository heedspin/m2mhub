class M2m::CsPopup < M2m::Base
  set_table_name 'cspopup'
  named_scope :for_key, lambda { |key|
    {
      :conditions => { :fcpopkey => key }
    }
  }
  named_scope :with_code, lambda { |code|
    {
      :conditions => { :fcpopval => code }
    }
  }
  def text
    self.fcpoptext.titleize
  end
end
# == Schema Information
#
# Table name: cspopup
#
#  fcpopkey         :string(20)      not null
#  fcpoptext        :string(80)      default(" "), not null
#  fcpopval         :string(10)      not null
#  fnorder          :integer         not null
#  fcpopacces       :string(1)       not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

