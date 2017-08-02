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

    def length_of_time
      open_time = self.versions.first.try(:created_at)
      close_time = self.versions.last.try(:created_at)
      if open_time.nil?
        nil
      else
        close_time - open_time
      end
    end

    def length_days
      (self.length_of_time / (24 * 60 * 60)).to_i
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