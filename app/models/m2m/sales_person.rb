# == Schema Information
#
# Table name: slspns
#
#  fdistno          :string(6)        default(""), not null
#  flastname        :string(25)       default(""), not null
#  fsalespn         :string(3)        default(""), not null
#  fterr            :string(10)       default(""), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fsalespn2        :string(3)        default(""), not null
#  fsalespn3        :string(3)        default(""), not null
#  fscompct2        :decimal(7, 2)    default(0.0), not null
#  fscompct3        :decimal(7, 2)    default(0.0), not null
#  flisfcast        :boolean          default(FALSE), not null
#  flterfcast       :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmnotes          :text             default(""), not null
#  fvendno          :string(6)        default(""), not null
#  fccommcode       :string(10)       default(""), not null
#  fnrate2          :decimal(8, 3)    default(0.0), not null
#  fUser            :string(30)       default(""), not null
#

class M2m::SalesPerson < M2m::Base
  set_table_name 'slspns'
  
  alias_attribute :commission_percentage, :fsalcompct
  
  scope :by_name, :order => :flastname
  
  def short_name
    self.flastname.strip
  end
  
  def name
    if self.initials.present? and (self.initials != self.short_name)
      "#{self.short_name} (#{self.initials})"
    else
      self.short_name
    end
  end
  
  def initials
    self.fsalespn.strip
  end
end
