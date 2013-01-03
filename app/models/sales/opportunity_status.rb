require 'plutolib/active_hash_methods'
class Sales::OpportunityStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :open => true,  :name => 'Active'},
    {:id => 2, :open => false, :name => 'Won'},
    {:id => 3, :open => true,  :name => 'On Hold', :cmethod => :hold},
    {:id => 4, :open => false, :name => 'Lost'},
    {:id => 5, :open => false, :name => 'Deleted'}
  ]
  class << self
    def not_deleted
      @not_deleted ||= all.select { |s| !s.deleted? }
    end
    def open
      @open ||= all.select(&:open?)
    end
    def closed
      @closed ||= all.select { |s| !s.open? }
    end
  end
  include Plutolib::ActiveHashMethods
end
