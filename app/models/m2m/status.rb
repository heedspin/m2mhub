require 'active_hash_methods'
class M2m::Status < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Open'},
    {:id => 2,  :name => 'Closed'},
    {:id => 3,  :name => 'Cancelled'},
    {:id => 4,  :name => 'On Hold'},
    {:id => 5,  :name => 'Shipped'},
    {:id => 6,  :name => 'Received'},    
    {:id => 7,  :name => 'Closed Short'},
    {:id => 8,  :name => 'Receiving'},
    {:id => 9,  :name => 'Partial'},
    {:id => 10, :name => 'Released'},
    {:id => 11, :name => 'Completed'}
  ]
  include ActiveHashMethods
  
  def self.find_by_name(txt)
    return nil unless txt.present?
    txt = txt.strip.downcase
    all.detect { |s| s.name.downcase == txt }
  end  
end
