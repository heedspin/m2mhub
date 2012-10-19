require 'active_hash_methods'
class BacklogGroup < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'All'},
  ]
  include ActiveHashMethods
  
  def filter_release?(release)
    false
  end
end
