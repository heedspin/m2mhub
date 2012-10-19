require 'active_hash_methods'
class M2mhub::ExternalEventStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Queued'},
    {:id => 2, :name => 'Success'},
    {:id => 3, :name => 'Error'},
    {:id => 4, :name => 'Rejected'}
  ]
  include ActiveHashMethods
end
