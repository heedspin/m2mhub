require 'active_hash_methods'
class M2mhub::NotificationType < ActiveHash::Base
  self.data = [
    {:id => 1, :cmethod => :ticket, :name => 'Lighthouse Ticket'},
    # {:id => 2, :cmethod => :email, :name => 'Email'},
    {:id => 3, :cmethod => :nothing, :name => 'Nothing'}
  ]
  include ActiveHashMethods
end

