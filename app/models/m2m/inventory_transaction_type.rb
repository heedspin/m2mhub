require 'active_hash_methods'
class M2m::InventoryTransactionType < ActiveHash::Base
  self.data = [
    {:id => 1, :key => 'T', :name => 'Transfers'},
    {:id => 2, :key => 'A', :name => 'Adjustment (On Hand)'},
    {:id => 3, :key => 'S', :name => 'Scrap'},
    {:id => 4, :key => 'R', :name => 'Receipts'},
    {:id => 5, :key => 'I', :name => 'Issues'},
    {:id => 6, :key => 'M', :name => 'Move To Finished Goods (Also A Receipt)'},
    {:id => 7, :key => 'O', :name => 'Sales Orders'},
    {:id => 8, :key => 'P', :name => 'Material Postings'},
    {:id => 9, :key => 'H', :name => 'Physical Inventory'},
  ]
  include ActiveHashMethods
end
