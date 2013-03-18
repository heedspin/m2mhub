require 'plutolib/active_hash_methods'
class Sales::OpportunityCommentType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Comment'},
    {:id => 2, :name => 'Ticket'},
    {:id => 3, :name => 'Quote'},
    {:id => 4, :name => 'Lost'},
    {:id => 5, :name => 'Sales Order'}
  ]
  include Plutolib::ActiveHashMethods
end
