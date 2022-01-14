require 'plutolib/active_hash_methods'
class Sales::QuoteStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Unapproved' },
    {:id => 2, :name => 'Approved' },
    {:id => 3, :name => 'Deleted'}
  ]
  include Plutolib::ActiveHashMethods  
end
