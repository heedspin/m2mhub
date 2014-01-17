module Lighthouse
  class Ticket
    def title
      attributes['title'] ||= ''
    end

    def title=(value)
      attributes['title'] = value
    end

    def assigned_user_id
      attributes['assigned_user_id'] ||= ''
    end

    def assigned_user_id=(value)
      attributes['assigned_user_id'] = value
    end
    
    def assigned_user_name
      attributes['assigned_user_name']
    end
    
    def watcher_ids=(value)
      attributes['multiple_watchers'] = value
    end
    
    def milestone_title
      attributes['milestone_title']
    end
    
    STATE_INVALID = 'invalid'
    
    def closed?
      self.closed
      # ['resolved', STATE_INVALID].include?(self.state)
    end
    
    def hold?
      self.state == 'hold'
    end
    
    def resolved?
      self.state == 'resolved'
    end
    
    def versions
      attributes['versions'] || []
    end
    
    ######################################
    # Trick formtastic:
    def new_record?
      false
    end
    
    def to_s
      "Ticket ##{self.id} #{self.title}"
    end
  end
end