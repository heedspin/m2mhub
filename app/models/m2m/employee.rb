# == Schema Information
#
# Table name: prempl
#
#  fempno           :char(9)          default("         "), not null
#  fname            :char(20)         default("                    "), not null
#  ffname           :char(20)         default("                    "), not null
#  fmi              :char(1)          default(" "), not null
#  fbirthdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcity            :varchar(35)      default(""), not null
#  fdept            :varchar(4)       default(""), not null
#  fendate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnshift          :integer          default(0), not null
#  fpaytype         :char(2)          default("  "), not null
#  fphone           :char(20)         default("                    "), not null
#  freghr           :decimal(7, 2)    default(0.0), not null
#  fssn             :varchar(50)      default(""), not null
#  fstate           :char(20)         default("                    "), not null
#  fzip             :char(10)         default("          "), not null
#  emgcontact       :varchar(30)      default(""), not null
#  emgphone         :char(20)         default("                    "), not null
#  fgross           :decimal(11, 2)   default(0.0), not null
#  fcountry         :char(25)         default("                         "), not null
#  fcemail          :varchar(60)      default(""), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  faddress         :varchar_max(2147 default(""), not null
#  fhiredate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fac              :char(20)         default("                    "), not null
#  fssnslt          :varbinary(32)    default("\x00"), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Employee < M2m::Base
  self.table_name = 'prempl'
  
  alias_attribute :employee_number, :fempno
  
  def first_name
    self.ffname.titleize
  end
  
  def last_name
    self.fname.titleize
  end
  
  def name
    @name ||= "#{self.first_name} #{self.last_name}"
  end
end
