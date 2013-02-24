require 'plutolib/active_hash_methods'
class Sales::Terms < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Net 30' },
    {:id => 2, :name => 'Net 60' },
    {:id => 3, :name => 'Net 90' },
    {:id => 4, :name => 'Prepay' },
    {:id => 5, :name => 'Due Now' },
    {:id => 6, :name => 'Cash On Delivery' }
  ]
  include Plutolib::ActiveHashMethods  
end
