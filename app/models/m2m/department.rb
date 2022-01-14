# == Schema Information
#
# Table name: prdept
#
#  fdeptno          :varchar(4)       default(""), not null
#  fdeptdesc        :varchar(35)      default(""), not null
#  fholaccno        :char(25)         default("                         "), not null
#  fothaccno        :char(25)         default("                         "), not null
#  fsickaccno       :char(25)         default("                         "), not null
#  fvacaccno        :char(25)         default("                         "), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    "), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Department < M2m::Base
  self.table_name = 'prdept'
  
  alias_attribute :department_number, :fdeptno
  
  def name
    self.fdeptdesc.strip.titleize
  end
end
