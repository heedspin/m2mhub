class M2m::InventoryVendor < M2m::Base
  set_table_name 'invend'
  alias_attribute :vendor_part_number, :fvpartno
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno
end


# == Schema Information
#
# Table name: invend
#
#  fpartno          :string(25)      default(""), not null
#  fpartrev         :string(3)       default(""), not null
#  fpriority        :string(1)       default(""), not null
#  fvendno          :string(6)       default(""), not null
#  fvconvfact       :decimal(13, 9)  default(0.0), not null
#  fvlastpc         :decimal(17, 5)  default(0.0), not null
#  fvlastpd         :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fvlastpq         :decimal(15, 5)  default(0.0), not null
#  fvleadtime       :decimal(7, 1)   default(0.0), not null
#  fvmeasure        :string(3)       default(""), not null
#  fvpartno         :string(25)      default(""), not null
#  fvptdes          :string(35)      default(""), not null
#  fclastpono       :string(6)       default(""), not null
#  fcjrdict         :string(10)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fvcomment        :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#

