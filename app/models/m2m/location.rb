# == Schema Information
#
# Table name: location
#
#  fcfacility       :string(20)       default(""), not null
#  flocation        :string(14)       default(""), not null
#  fcinspect        :string(1)        default(""), not null
#  flocdesc         :string(30)       default(""), not null
#  fcmrpexcl        :string(1)        default(""), not null
#  fccity           :string(20)       default(""), not null
#  fcstate          :string(20)       default(""), not null
#  fczip            :string(10)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  fcfname          :string(15)       default(""), not null
#  fclname          :string(20)       default(""), not null
#  fcphone          :string(20)       default(""), not null
#  fcfax            :string(20)       default(""), not null
#  fcemail          :string(128)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmstreet         :text             default(""), not null
#

class M2m::Location < M2m::Base
  self.table_name = 'location'
  
  scope :inspection, :conditions => { :fcinspect => 'Y' }
  
  has_many :inventory_locations, :class_name => 'M2m::InventoryLocation', :foreign_key => :flocation, :primary_key => :flocation
end
