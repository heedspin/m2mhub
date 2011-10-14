require 'active_hash_methods'
class UserRole < ActiveHash::Base
  self.data = [
    { :id => 1, :name => 'Admin' },
    { :id => 2, :name => 'Sales'},
    { :id => 3, :name => 'Shipping'}
  ]
  include ActiveHashMethods  
  
  def self.default
    UserRole.find(2)
  end
end
