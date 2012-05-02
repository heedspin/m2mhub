require 'active_hash_methods'
class UserRole < ActiveHash::Base
  self.data = [
    { :id => 1, :name => 'Admin' },
    { :id => 2, :name => 'Sales'},
    { :id => 3, :name => 'Shipping'},
    { :id => 4, :name => 'Manager'},
    { :id => 5, :name => 'Doogle Admin'}
  ]
  include ActiveHashMethods  
  
  def self.default
    UserRole.find(2)
  end
  
  def authorization_key
    self.name.gsub(/[ -\/]/, '_').downcase.to_sym
  end
end
