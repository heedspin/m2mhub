require 'active_hash_methods'
class M2m::Status < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Open'},
    {:id => 2,  :name => 'Closed'},
    {:id => 3,  :name => 'Cancelled'},
    {:id => 4,  :name => 'On Hold'},
    {:id => 5,  :name => 'Shipped',      :groups => [:shipping]},
    {:id => 6,  :name => 'Received',     :groups => [:shipping]},
    {:id => 7,  :name => 'Closed Short', :groups => [:shipping, :purchasing]},
    {:id => 8,  :name => 'Receiving',    :groups => [:shipping, :purchasing]},
    {:id => 9,  :name => 'Partial',      :groups => [:shipping, :purchasing]}
  ]
  include ActiveHashMethods
  
  def self.find_by_name(txt)
    return nil unless txt.present?
    txt = txt.strip.downcase
    all.detect { |s| s.name.downcase == txt }
  end  
end
