require 'plutolib/active_hash_methods'
class Sales::OpportunityWinType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Sample Order'},
    {:id => 2, :name => 'Tooling Order'},
    {:id => 3, :name => 'Production Order'},
  ]
  include Plutolib::ActiveHashMethods
end
