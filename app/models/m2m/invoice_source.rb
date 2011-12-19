require 'active_hash_methods'
class M2m::InvoiceSource < ActiveHash::Base
  self.data = [
    {:id => 1, :key => 'R', :name => 'Return'},
    {:id => 2, :key => 'I', :name => 'Sale'},
    {:id => 3, :key => 'C', :name => 'Allowance'}
  ]
  include ActiveHashMethods
end
