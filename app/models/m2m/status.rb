require 'plutolib/active_hash_methods'
class M2m::Status < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Open'},
    {:id => 2,  :name => 'Closed'},
    {:id => 3,  :name => 'Cancelled'},
    {:id => 4,  :name => 'On Hold', :aliases => [ 'Hold' ]},
    {:id => 5,  :name => 'Shipped'},
    {:id => 6,  :name => 'Received'},    
    {:id => 7,  :name => 'Closed Short'},
    {:id => 8,  :name => 'Receiving'},
    {:id => 9,  :name => 'Partial'},
    {:id => 10, :name => 'Released'},
    {:id => 11, :name => 'Completed'},
    {:id => 12, :name => 'Void'}
  ]
  include Plutolib::ActiveHashMethods
  
  def self.find_by_name(txt)
    return nil unless txt.present?
    txt = txt.strip.downcase
    all.detect { |s| s.has_name?(txt) }
  end
  
  def has_name?(txt)
    txt = txt.downcase
    (self.name.downcase == txt.downcase) || (self.aliases || []).map(&:downcase).include?(txt)
  end
end
