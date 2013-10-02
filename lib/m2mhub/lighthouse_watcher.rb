module M2mhub::LighthouseWatcher
  def lighthouse_watcher_create(title, body, assigned_user_id=nil, milestone_id=nil, watcher_ids=nil)
    log "Creating ticket with project_id = #{self.lighthouse_project_id}, title=#{title}, assigned_user_id=#{assigned_user_id}, and body=#{body}"
    self.lighthouse_ticket = Lighthouse::Ticket.new(:project_id => self.lighthouse_project_id)
    self.lighthouse_ticket.title = title
    self.lighthouse_ticket.body = body
    self.lighthouse_ticket.assigned_user_id = assigned_user_id if assigned_user_id
    self.lighthouse_ticket.milestone_id = milestone_id if milestone_id
    if watcher_ids #and Rails.env.production?
      self.lighthouse_ticket.watcher_ids = watcher_ids.select(&:present?)
    end
    if self.lighthouse_ticket.save
      self.lighthouse_ticket_id = self.lighthouse_ticket.id
      self.lighthouse_watcher_update
    else
      false
    end
  end

  def lighthouse_watcher_update
    if self.lighthouse_ticket
      self.lighthouse_closed       = self.lighthouse_ticket.closed?
      self.lighthouse_status       = self.lighthouse_ticket.state
      self.lighthouse_url          = self.lighthouse_ticket.url
      self.lighthouse_milestone    = self.lighthouse_ticket.milestone_title
      self.lighthouse_title        = self.lighthouse_ticket.title
      self.lighthouse_project_name = self.lighthouse_project.try(:name)
      if last_comment = self.lighthouse_ticket.versions.last
        self.lighthouse_last_assigned_user_name = last_comment.assigned_user_name
        self.lighthouse_last_comment            = last_comment.body_html
        self.lighthouse_last_updated_at         = last_comment.created_at
        self.lighthouse_last_updater            = last_comment.user_name
        self.updated_at                         = self.lighthouse_last_updated_at
      else
        self.lighthouse_last_assigned_user_name = self.lighthouse_ticket.assigned_user_name
        self.lighthouse_last_comment            = self.lighthouse_ticket.body_html
      end
    else
      self.lighthouse_closed = self.lighthouse_status = self.lighthouse_url = nil
    end
  end

  def self.included(base)
    base.class_eval <<-RUBY
    belongs_to_lighthouse_ticket
    belongs_to_lighthouse_project
    RUBY
  end

end
