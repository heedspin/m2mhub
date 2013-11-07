require 'plutolib/active_hash_methods'
class Shipping::IncludeJobs < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'No Jobs', :cmethod => 'none', :job_status => []},
    {:id => 2, :name => 'Released Jobs', :cmethod => 'released', :job_status => [M2m::Status.released.name, M2m::Status.completed.name]}, 
    {:id => 3, :name => 'Open & Released', :cmethod => 'open', :job_status => [M2m::Status.open.name, M2m::Status.released.name, M2m::Status.completed.name]} 
  ]
  include Plutolib::ActiveHashMethods
end
