require 'active_hash_methods'
class DelayedJobStatus < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Queued'},
    {:id => 2, :name => 'Running'},
    {:id => 3, :name => 'Complete'},
    {:id => 4, :name => 'Error'},
    {:id => 5, :name => 'Stopping'},
    {:id => 6, :name => 'Stopped'}
  ]
  include ActiveHashMethods
  
  def in_progress?
    self.queued? || self.running?
  end
end
