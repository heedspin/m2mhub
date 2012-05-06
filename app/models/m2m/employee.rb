# == Schema Information
#
# Table name: prempl
#
#  fempno           :string(9)       default(""), not null
#  fname            :string(20)      default(""), not null
#  ffname           :string(20)      default(""), not null
#  fmi              :string(1)       default(""), not null
#  fbirthdate       :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcity            :string(35)      default(""), not null
#  fdept            :string(2)       default(""), not null
#  fendate          :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnshift          :integer(4)      default(0), not null
#  fpaytype         :string(2)       default(""), not null
#  fphone           :string(20)      default(""), not null
#  freghr           :decimal(7, 2)   default(0.0), not null
#  fssn             :string(15)      default(""), not null
#  fstate           :string(20)      default(""), not null
#  fzip             :string(10)      default(""), not null
#  emgcontact       :string(30)      default(""), not null
#  emgphone         :string(20)      default(""), not null
#  fgross           :decimal(11, 2)  default(0.0), not null
#  fcountry         :string(25)      default(""), not null
#  fcemail          :string(60)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  faddress         :text            default(""), not null
#  fhiredate        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#

class M2m::Employee < M2m::Base
  set_table_name 'prempl'
  
  alias_attribute :employee_number, :fempno
  
  def first_name
    self.ffname.titleize
  end
  
  def last_name
    self.ffname.titleize
  end
  
  def name
    @name ||= "#{self.first_name} #{self.last_name}"
  end
end
