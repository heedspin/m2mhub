require 'plutolib/active_hash_methods'
class M2m::PurchaseOrderStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :m2mname => 'OPEN',      :char => 'O', :name => 'Open'},
    {:id => 2, :m2mname => 'CLOSED',    :char => 'C', :name => 'Closed'},
    {:id => 3, :m2mname => 'CANCELLED', :char => 'X', :name => 'Cancelled'},
    {:id => 4, :m2mname => 'STARTED',   :char => 'S', :name => 'Started'},
    {:id => 5, :m2mname => 'HOLD',      :char => 'H', :name => 'Hold'}
  ]
  include Plutolib::ActiveHashMethods
end
