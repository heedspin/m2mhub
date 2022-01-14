# == Schema Information
#
# Table name: invend
#
#  fpartno          :char(25)         default("                         "), not null
#  fpartrev         :char(3)          default("   "), not null
#  fpriority        :char(1)          default(" "), not null
#  fvendno          :char(6)          default("      "), not null
#  fvconvfact       :decimal(13, 9)   default(0.0), not null
#  fvlastpc         :decimal(17, 5)   default(0.0), not null
#  fvlastpd         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fvlastpq         :decimal(15, 5)   default(0.0), not null
#  fvleadtime       :decimal(7, 1)    default(0.0), not null
#  fvmeasure        :char(3)          default("   "), not null
#  fvpartno         :char(25)         default("                         "), not null
#  fvptdes          :varchar(35)      default(""), not null
#  fclastpono       :varchar(10)      default(""), not null
#  fcjrdict         :char(10)         default("          "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fvcomment        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fvlastapno       :varchar(20)      default(""), not null
#  fvlasttxnpc      :decimal(17, 5)   default(0.0), not null
#  fvfactor         :decimal(22, 10)  default(0.0), not null
#  fccurid          :char(3)          default("   "), not null
#  fmulticurr       :boolean          default(FALSE), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::InventoryVendor < M2m::Base
  self.table_name = 'invend'
  alias_attribute :vendor_part_number, :fvpartno
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => :fvendno, :primary_key => :fvendno
  alias_attribute :vendor_number, :fvendno
  
  scope :for_item, -> (item) {
    where :fpartno => item.part_number, :fpartrev => item.revision
  }
  scope :part_number, -> (part_number) {
    where :fpartno => part_number
  }
  scope :revision, -> (revision) {
    where :fpartrev => revision
  }
end

