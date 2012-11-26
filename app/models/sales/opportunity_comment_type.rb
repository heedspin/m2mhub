require 'plutolib/active_hash_methods'
class Sales::OpportunityCommentType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Comment'},
    {:id => 2, :name => 'Ticket'}
  ]
  include Plutolib::ActiveHashMethods
end
