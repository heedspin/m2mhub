# == Schema Information
#
# Table name: location
#
#  fcfacility       :char(20)         default("                    "), not null
#  flocation        :varchar(14)      default(""), not null
#  fcinspect        :char(1)          default(" "), not null
#  flocdesc         :varchar(30)      default(""), not null
#  fcmrpexcl        :char(1)          default(" "), not null
#  fccity           :varchar(20)      default(""), not null
#  fcstate          :varchar(20)      default(""), not null
#  fczip            :char(10)         default("          "), not null
#  fccountry        :varchar(25)      default(""), not null
#  fcfname          :varchar(15)      default(""), not null
#  fclname          :varchar(20)      default(""), not null
#  fcphone          :char(20)         default("                    "), not null
#  fcfax            :char(20)         default("                    "), not null
#  fcemail          :varchar(128)     default(""), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmstreet         :varchar_max(2147 default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Location < M2m::Base
  self.table_name = 'location'

  alias_attribute :name, :flocation
  
  scope :inspection, -> { where(:fcinspect => 'Y') }
  
  has_many :inventory_locations, :class_name => 'M2m::InventoryLocation', :foreign_key => :flocation, :primary_key => :flocation
end
