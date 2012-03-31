require 'active_hash_methods'
class M2m::JobInternalType < ActiveHash::Base
  self.data = [
    {:key => '1', :name => 'Stock'},
    {:key => '2', :name => 'Internal Use'},
  ]
  include ActiveHashMethods
end
