require 'plutolib/active_hash_methods'
class Sales::LeadLevel < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Prospect' },
    {:id => 2,  :name => 'Existing Customer' },
    {:id => 3,  :name => 'Past Customer'},
    {:id => 4,  :name => 'Poor Prospect'},
  ]
  include Plutolib::ActiveHashMethods
end
