require 'plutolib/active_hash_methods'
class Sales::RepStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Unknown' },
    {:id => 2, :name => 'Connected' },
    {:id => 3, :name => 'No Action'}
  ]
  include Plutolib::ActiveHashMethods  
end
