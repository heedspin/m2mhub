require 'active_hash_methods'
class Sales::OpportunityStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Active'},
    {:id => 2, :name => 'Won'},
    {:id => 3, :name => 'On Hold', :cmethod => :hold},
    {:id => 4, :name => 'Lost'},
    {:id => 5, :name => 'Deleted'}
  ]
  def self.not_deleted
    all.select { |s| !s.deleted? }
  end
  include ActiveHashMethods
end
