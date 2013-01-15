require 'plutolib/active_hash_methods'
class Sales::RepStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Unassigned' },
    {:id => 2, :name => 'Assigned' },
    {:id => 3, :name => 'No Action'}
  ]
  include Plutolib::ActiveHashMethods  
end
