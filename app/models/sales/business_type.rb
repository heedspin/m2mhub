require 'plutolib/active_hash_methods'
class Sales::BusinessType < ActiveHash::Base
  self.data = [
    {:id => 1,  :name => 'Medical' },
    {:id => 2,  :name => 'Fuel' },
    {:id => 3,  :name => 'Contract Manufacturer'},
    {:id => 4,  :name => 'Design House'},
    {:id => 5,  :name => 'Industrial Electronics'},
    {:id => 6,  :name => 'Consumer Electronics'},
    {:id => 8,  :name => 'Military'},
    {:id => 7,  :name => 'Other'}
  ]
  include Plutolib::ActiveHashMethods
  
  def self.by_name
    all.sort_by(&:name)
  end
end
