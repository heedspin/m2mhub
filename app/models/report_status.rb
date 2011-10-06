require 'active_hash_methods'
class ReportStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Open'},
    {:id => 2, :name => 'Closed'},
    {:id => 3, :name => 'Deleted'}
  ]
  include ActiveHashMethods
end
