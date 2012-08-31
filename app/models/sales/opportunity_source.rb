require 'active_hash_methods'
class Sales::OpportunitySource < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Web'},
    {:id => 2, :name => 'Sales Rep'},
    {:id => 3, :name => 'Phone Call'},
    {:id => 4, :name => 'Other'}
  ]
  include ActiveHashMethods
end
