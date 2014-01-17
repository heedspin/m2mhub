class Production::InspectionItem
  def self.all
    inventory_locations = M2m::Location.inspection.first.inventory_locations
    M2m::Item.attach_items(inventory_locations)
    inventory_locations.map { |l| new(l) }
  end
  
  attr_accessor :inventory_location
  
  def initialize(inventory_location)
    @inventory_location = inventory_location
  end
  
  def last_inbound_transaction
    @last_inbound_transaction ||= self.inventory_location.inbound_inventory_transactions.by_time_desc.first
  end
  
  def item
    @item ||= self.inventory_location.item
  end
end