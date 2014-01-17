require 'plutolib/active_hash_methods'
class M2mhub::TriggerState < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Enabled'},
    {:id => 2, :name => 'Disabled'},
    {:id => 3, :name => 'Deleted'}
  ]
  include Plutolib::ActiveHashMethods
end

