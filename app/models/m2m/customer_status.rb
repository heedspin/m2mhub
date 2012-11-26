require 'plutolib/active_hash_methods'
class M2m::CustomerStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :key => 'G', :name => 'Good Standing'},
    {:id => 2, :key => 'H', :name => 'Credit Hold'}
  ]
  include Plutolib::ActiveHashMethods
end
