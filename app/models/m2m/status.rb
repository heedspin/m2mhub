require 'active_hash_methods'
class M2m::Status < ActiveHash::Base
  self.data = [
    {:name => 'Open'},
    {:name => 'Closed'},
    {:name => 'Cancelled'}
  ]
  include ActiveHashMethods
end
