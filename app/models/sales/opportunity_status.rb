require 'plutolib/active_hash_methods'
class Sales::OpportunityStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :open => true,  :name => 'Active'},
    {:id => 2, :open => false, :name => 'Won'},
    {:id => 3, :open => true,  :name => 'On Hold', :cmethod => :hold},
    {:id => 4, :open => false, :name => 'Lost'},
    {:id => 6, :open => false, :name => 'Sales Rep', :cmethod => :sales_rep},
    {:id => 7, :open => false, :name => 'Closed'},
    {:id => 5, :open => false, :name => 'Deleted'}
  ]
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
