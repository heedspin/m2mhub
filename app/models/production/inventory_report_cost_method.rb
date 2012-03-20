require 'active_hash_methods'
class Production::InventoryReportCostMethod < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Standard Cost', :item_key => 'standard_cost'},
    {:id => 2, :name => 'Rolled Standard Cost', :item_key => 'rolled_standard_cost'},
    {:id => 3, :name => 'Last Cost', :item_key => 'last_cost'},
    {:id => 4, :name => 'Average Cost', :item_key => 'average_cost'}
  ]
  include ActiveHashMethods
end
    

