require 'plutolib/active_hash_methods'
class Quality::InspectionTaskType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Incoming Inspection'},
    {:id => 2, :name => 'RMA Inspection'}
  ]
  include Plutolib::ActiveHashMethods
end
