require 'plutolib/active_hash_methods'
class UserState < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Unconfirmed'},
    {:id => 2, :name => 'Active'},
    {:id => 3, :name => 'Suspended'},
    {:id => 4, :name => 'Deleted'}
  ]
  include Plutolib::ActiveHashMethods
end
