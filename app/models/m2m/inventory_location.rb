class M2m::InventoryLocation < M2m::Base
  set_table_name 'inonhd'
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fpartno, :fpartrev] #, :primary_key => :fpartno    

  alias_attribute :quantity_on_hand, :fonhand
  alias_attribute :bin, :fbinno

  def part_number
    @part_number ||= self.fpartno.strip
  end
  
  def revision
    @revision ||= self.fpartrev.strip
  end

  named_scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision } 
    }
  }

  named_scope :with_part_numbers, lambda { |part_numbers|
    {
      :conditions => [ 'inonhd.fpartno in (?)', part_numbers]
    }
  }

  def self.attach_to_items(locations, items)
    if (locations.size > 0) and (items.size > 0)
      items.each do |item|
        item.locations = locations.select { |l| (l.part_number == item.part_number) && (l.revision == item.revision) }
      end
    end
  end
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

