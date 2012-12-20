require 'plutolib/active_hash_methods'
class Quality::InspectionTaskStatus < ActiveHash::Base
  self.data = [
    {:id => 5, :name => 'All Open', :children_ids => [1, 2]},
    {:id => 1, :name => 'Awaiting Receipt'},
    {:id => 2, :name => 'In Inspection'},
    {:id => 3, :name => 'Closed'},
    {:id => 4, :name => 'Deleted'}
  ]
  def children
    @children ||= self.children_ids.nil? ? [] : self.children_ids.map { |i| Quality::InspectionTaskStatus.find(i) }
  end
  class << self
    def options
      @options ||= all.select { |s| s.children_ids.nil? and !s.deleted? }
    end
    def open_ids
      [1, 2]
    end
  end
  include Plutolib::ActiveHashMethods
end
