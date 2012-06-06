# == Schema Information
#
# Table name: slspns
#
#  fdistno          :string(6)       default(""), not null
#  flastname        :string(25)      default(""), not null
#  fsalespn         :string(3)       default(""), not null
#  fterr            :string(10)      default(""), not null
#  fsalcompct       :decimal(8, 3)   default(0.0), not null
#  fsalespn2        :string(3)       default(""), not null
#  fsalespn3        :string(3)       default(""), not null
#  fscompct2        :decimal(7, 2)   default(0.0), not null
#  fscompct3        :decimal(7, 2)   default(0.0), not null
#  flisfcast        :boolean         default(FALSE), not null
#  flterfcast       :boolean         default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fmnotes          :text            default(""), not null
#  fvendno          :string(6)       default(""), not null
#  fccommcode       :string(10)      default(""), not null
#  fnrate2          :decimal(8, 3)   default(0.0), not null
#  fUser            :string(30)      default(""), not null
#

class M2m::SalesPerson < M2m::Base
  set_table_name 'slspns'
  
  scope :by_name, :order => :flastname
  
  def name
    self.flastname.strip
  end
  
  def initials
    self.fdistno.strip
  end
end
