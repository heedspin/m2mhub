require 'active_hash_methods'
class ReportTimePeriod < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Day'},
    {:id => 2, :name => 'Week'},
    {:id => 3, :name => 'Month'},
    {:id => 4, :name => 'Year'}
  ]
  include ActiveHashMethods
end
