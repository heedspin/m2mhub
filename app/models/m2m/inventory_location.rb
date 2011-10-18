class M2m::InventoryLocation < M2m::Base
  set_table_name 'inonhd'
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => :fpartno, :primary_key => :fpartno    
end

# == Schema Information
#
# Table name: inonhd
#
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  fbinno           :string(14)      not null
#  flocation        :string(14)      not null
#  fexpdate         :datetime        not null
#  flot             :string(20)      not null
#  fonhand          :decimal(15, 5)  not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fac              :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#

