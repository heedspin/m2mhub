# == Schema Information
#
# Table name: inonhd
#
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  fbinno           :string(14)       default(""), not null
#  flocation        :string(14)       default(""), not null
#  fexpdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flot             :string(20)       default(""), not null
#  fonhand          :decimal(15, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
#

class M2m::InventoryLocation < M2m::Base
  self.table_name = 'inonhd'
  belongs_to_item :fpartno, :fpartrev
  belongs_to :location, :class_name => 'M2m::Location', :foreign_key => :flocation, :primary_key => :flocation

  alias_attribute :quantity_on_hand, :fonhand
  alias_attribute :bin, :fbinno

  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision } 
    }
  }
  scope :with_part_numbers, lambda { |part_numbers|
    {
      :conditions => [ 'inonhd.fpartno in (?)', part_numbers]
    }
  }
  scope :with_quantity_on_hand, :conditions => 'inonhd.fonhand > 0'
  
  def location_description
    if self.bin.present?
      self.bin
    else
      self.flocation.titleize
    end
  end

  def self.attach_to_items(locations, items)
    if (locations.size > 0) and (items.size > 0)
      items.each do |item|
        item.locations = locations.select { |l| (l.part_number == item.part_number) && (l.revision == item.revision) }
      end
    end
  end
  
  # M2m::Location.inspection.first.inventory_locations.first.inventory_transactions
  def inbound_inventory_transactions
    M2m::InventoryTransaction.to_location(self.flocation).part_number(self.part_number)
  end
  
end

