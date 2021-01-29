require 'plutolib/active_hash_methods'
class Sales::LeadLevel < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Prospect' },
    {:id => 2,  :name => 'Existing Customer' },
    {:id => 3,  :name => 'Past Customer'},
    {:id => 4,  :name => 'Poor Prospect'},
  ]
  include Plutolib::ActiveHashMethods

  # Quack like a Search duck.
  def lead_level_ids
    [self.id]
  end

  class Search < ActiveHash::Base
     self.data = [
       {:id => 5,  :name => 'Open', :cmethod => :open_lead, :_lead_level_ids => [1, 2, 3] }, 
       {:id => 1,  :name => 'Prospect' },
       {:id => 2,  :name => 'Existing Customer' },
       {:id => 3,  :name => 'Past Customer'},
       {:id => 4,  :name => 'Poor Prospect'},
       {:id => 6,  :name => 'All', :_lead_level_ids => [1, 2, 3, 4]}
     ]
     include Plutolib::ActiveHashMethods
     
     def lead_level_ids
       @lead_level_ids ||= (self._lead_level_ids || [self.id])
     end
  end
end
