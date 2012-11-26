require 'plutolib/active_hash_methods'
class M2m::JobType < ActiveHash::Base
  self.data = [
    {:key => 'C', :name => 'Customer'},
    {:key => 'I', :name => 'Internal'},
    {:key => 'T', :name => 'Template'},
  ]
  include Plutolib::ActiveHashMethods
end
