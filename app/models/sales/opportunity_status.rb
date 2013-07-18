require 'plutolib/active_hash_methods'
class Sales::OpportunityStatus < ActiveHash::Base
  self.data = [
    {:id => 8, :open => false, :name => 'All', :_children_ids => [1, 2, 3, 4, 7]},
    {:id => 9, :open => false, :name => 'Open and Hold', :_children_ids => [1, 2, 3]},
    {:id => 1, :open => true,  :name => 'Open', :cmethod => :active},
    {:id => 2, :open => false, :name => 'Won'},
    {:id => 3, :open => true,  :name => 'On Hold', :cmethod => :hold},
    {:id => 4, :open => false, :name => 'Lost'},
    {:id => 7, :open => false, :name => 'Closed'},
    {:id => 5, :open => false, :name => 'Deleted'}
  ]
  def children_ids
    self._children_ids || [ self.id ]
  end
  class << self
    def all_not_deleted
      @all_not_deleted ||= all.select { |s| !s.deleted? }
    end
    def all_open
      @all_open ||= all.select(&:open?)
    end
    def all_closed
      @all_closed ||= all.select { |s| !s.open? }
    end
  end
  include Plutolib::ActiveHashMethods
end
