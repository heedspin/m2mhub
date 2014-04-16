require 'plutolib/active_hash_methods'
class Sales::OpportunityStatus < ActiveHash::Base
  self.data = [
    {:id => 8, :open => false, :name => 'All', :cmethod => :is_all, :_children_ids => [1, 2, 3, 4, 7]},
    {:id => 9, :open => false, :name => 'Open and Hold', :_children_ids => [1, 2, 3]},
    {:id => 1, :open => true,  :name => 'Open', :cmethod => :active, :_children_ids => [1, 2]},
    {:id => 2, :open => true, :name => 'Won'},
    {:id => 3, :open => true,  :name => 'On Hold', :cmethod => :hold},
    {:id => 4, :open => false, :name => 'Lost'},
    {:id => 7, :open => false, :name => 'Closed'},
    {:id => 5, :open => false, :name => 'Deleted'}
  ]
  def children_ids
    self._children_ids || [ self.id ]
  end
  class << self
    def all_assignable
      @all_assignable ||= all.select { |s| !s.deleted? && !s.is_all? && !s.open_and_hold? }
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
