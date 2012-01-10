class M2m::InventoryVendor < M2m::Base
  set_table_name 'invend'
  alias_attribute :vendor_part_number, :fvpartno
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno
end

# == Schema Information
#
# Table name: invend
#
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  fpriority        :string(1)       not null
#  fvendno          :string(6)       not null
#  fvconvfact       :decimal(13, 9)  not null
#  fvlastpc         :decimal(17, 5)  not null
#  fvlastpd         :datetime        not null
#  fvlastpq         :decimal(15, 5)  not null
#  fvleadtime       :decimal(7, 1)   not null
#  fvmeasure        :string(3)       not null
#  fvpartno         :string(25)      not null
#  fvptdes          :string(35)      default(" "), not null
#  fclastpono       :string(6)       not null
#  fcjrdict         :string(10)      not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fvcomment        :text            default(" "), not null
#  fac              :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#

