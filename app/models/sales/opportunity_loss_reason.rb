require 'active_hash_methods'
class Sales::OpportunityLossReason < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Customer Stopped Responding', :cmethod => :dark },
    {:id => 2, :name => 'Customer Would Not Say', :cmethod => :unknown },
    {:id => 3, :name => 'Cost / Price', :cmethod => :cost},
    {:id => 4, :name => 'Dimensions'},
    {:id => 5, :name => 'Resolution'},
    {:id => 6, :name => 'Features'},
    {:id => 7, :name => 'Other'},
    {:id => 8, :name => 'Customer Event (E.g., project cancelled)'}
  ]
  include ActiveHashMethods
end
