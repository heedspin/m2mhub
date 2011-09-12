require 'active_hash_methods'
class M2m::Terms < ActiveHash::Base
  self.data = [
    {:key => 'A', :name => 'Net 30'},
    {:key => 'F', :name => '2% 10, Net 30'},
    {:key => 'I', :name => 'Net 60'},
  ]
  # include ActiveHashMethods
end
