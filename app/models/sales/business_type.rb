require 'plutolib/active_hash_methods'
class Sales::BusinessType < ActiveHash::Base
  self.data = [
    {id: 1, name: 'Aerospace', parent: 100},
    {id: 2, name: 'Automotive', parent: 100},
    {id: 4, name: 'Commercial Electronics'},
    {id: 5, name: 'Communications', parent: 100},
    {id: 6, name: 'Consumer Electronics'},
    {id: 7, name: 'Defense', parent: 100},
    {id: 8, name: 'Food', parent: 100},
    {id: 9, name: 'Heavy Equipment'},
    {id: 10, name: 'IT Electronics'},
    {id: 11, name: 'Industrial Electronics'},
    {id: 12, name: 'Medical'},
    {id: 13, name: 'Metering', parent: 16},
    {id: 14, name: 'Oil & Gas'},
    {id: 15, name: 'Parking Meters', parent: 100},
    {id: 16, name: 'Safety'},
    {id: 17, name: 'Test & Measurement', parent: 4},
    {id: 18, name: 'Vending', parent: 100},
    {id: 19, name: 'Welding', parent: 100},
    {id: 20, name: 'Windows', parent: 100},
    {id: 100, name: 'Other'},
    {id: 101, name: 'Ignore'}
  ]
  include Plutolib::ActiveHashMethods
  
  def self.by_name
    all.sort_by(&:name)
  end
end
