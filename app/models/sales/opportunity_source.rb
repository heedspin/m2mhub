require 'active_hash_methods'
class Sales::OpportunitySource < ActiveHash::Base
  self.data = [
    {:id => 1, :position => 1, :name => 'Web'},
    {:id => 2, :position => 2, :name => 'Sales Rep'},
    {:id => 3, :position => 3, :name => 'Phone Call'},
    {:id => 4, :position => 4, :name => 'Email'},
    {:id => 5, :position => 5, :name => 'Inside Sales / Existing'},
    {:id => 7, :position => 6, :name => 'Conference'},
    {:id => 8, :position => 7, :name => 'Advertisement'},
    {:id => 6, :position => 8, :name => 'Other'},
  ]
  include ActiveHashMethods
end
