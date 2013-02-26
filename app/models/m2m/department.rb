# == Schema Information
#
# Table name: prdept
#
#  fdeptno          :string(2)        default(""), not null
#  fdeptdesc        :string(35)       default(""), not null
#  fholaccno        :string(25)       default(""), not null
#  fothaccno        :string(25)       default(""), not null
#  fsickaccno       :string(25)       default(""), not null
#  fvacaccno        :string(25)       default(""), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fac              :string(20)       default(""), not null
#

class M2m::Department < M2m::Base
  set_table_name 'prdept'
  
  alias_attribute :department_number, :fdeptno
  
  def name
    self.fdeptdesc.strip.titleize
  end
end
