require 'plutolib/active_hash_methods'
class M2m::InventoryTransactionType < ActiveHash::Base
  self.data = [
    {:id => 1, :key => 'T', :name => 'Transfers'},
    {:id => 2, :key => 'A', :name => 'Adjustment (On Hand)'},
    {:id => 3, :key => 'S', :name => 'Scrap', :short_name => 'Scrp'},
    {:id => 4, :key => 'R', :name => 'Receipts', :short_name => 'Rcv'},
    {:id => 5, :key => 'I', :name => 'Issues', :short_name => 'Iss'},
    {:id => 6, :key => 'M', :name => 'Move To Finished Goods (Also A Receipt)', :cmethod => 'moves', :short_name => 'Fnsh'},
    {:id => 7, :key => 'O', :name => 'Sales Orders', :short_name => 'Sld'},
    {:id => 8, :key => 'P', :name => 'Material Postings'},
    {:id => 9, :key => 'H', :name => 'Physical Inventory'},
  ]
  include Plutolib::ActiveHashMethods
  
  def self.all_receipts
    [self.receipts, self.moves]
  end
  def self.outgoing
    [self.issues, self.sales_orders]
  end
  def short_name
    attributes[:short_name] || self.name
  end
end
