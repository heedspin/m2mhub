require 'plutolib/active_hash_methods'
class M2m::PurchaseOrderStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :m2mname => 'OPEN',      :name => 'Open'},
    {:id => 2, :m2mname => 'CLOSED',    :name => 'Closed'},
    {:id => 3, :m2mname => 'CANCELLED', :name => 'Cancelled'},
    {:id => 4, :m2mname => 'STARTED',   :name => 'Started'}
  ]
  include Plutolib::ActiveHashMethods
end
