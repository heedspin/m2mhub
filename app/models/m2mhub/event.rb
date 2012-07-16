# == Schema Information
#
# Table name: m2mhub_events
#
#  id                    :integer(4)      not null, primary key
#  trigger_id            :integer(4)
#  erp_type              :string(255)
#  erp_id                :integer(4)
#  erp_number            :string(255)
#  lighthouse_ticket_id  :string(255)
#  lighthouse_project_id :string(255)
#  title                 :string(255)
#  user_id               :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_status         :string(255)
#  closed                :boolean(1)
#  ticket_url            :string(255)
#  body                  :text
#

class M2mhub::Event < ApplicationModel
  set_table_name 'm2mhub_events'
  belongs_to :trigger, :class_name => 'M2mhub::Trigger', :foreign_key => 'trigger_id'
  belongs_to :user
  scope :since, lambda { |date|
    {
      :conditions => [ 'created_at >= ?', date ]
    }
  }
  scope :latest_first, :order => 'm2mhub_events.created_at desc'
  scope :open_or_recently_closed, lambda { 
    {
      :conditions => [ 'm2mhub_events.closed = false or m2mhub_events.closed is null or m2mhub_events.updated_at >= ?', Time.now.advance(:hours => -24) ]
    }
  }
  scope :valid, :conditions => ['m2mhub_events.ticket_status != ?', Lighthouse::Ticket::STATE_INVALID]

  def ticket
    if @ticket.nil? and self.lighthouse_ticket_id
      begin
        if @ticket = Lighthouse::Ticket.find(self.lighthouse_ticket_id, :params => { :project_id => self.lighthouse_project_id })
          # Convert to time objects.
          @ticket.created_at = Time.parse(@ticket.created_at)
          @ticket.versions.each do |v|
            v.created_at = Time.parse(v.created_at)
          end
        end
      rescue ActiveResource::ResourceNotFound
        # Bad link...
      end
    end
    @ticket
  end
  
  def create_ticket(title, body)
    @ticket = Lighthouse::Ticket.new(:project_id => self.trigger.lighthouse_project_id)
    @ticket.title = title
    @ticket.body = body
    @ticket.assigned_user_id = Rails.env.production? ? self.user.try(:lighthouse_user_id) : AppConfig.m2mhub_event_test_lighthouse_user_id
    @ticket.watcher_ids = Rails.env.production? ? self.trigger.users.map(&:lighthouse_user_id) : []
    if @ticket.save
      self.lighthouse_project_id = self.trigger.lighthouse_project_id
      self.lighthouse_ticket_id = @ticket.id
      self.closed = @ticket.closed?
      self.ticket_status = @ticket.state
      self.ticket_url = @ticket.url
    else
      false
    end
  end
  
  def update_status!
    if self.trigger.notification_type.ticket? and self.ticket
      self.closed = self.ticket.closed?
      self.ticket_status = self.ticket.state
      self.ticket_url = ticket.url
    else
      self.ticket_status = nil
      self.ticket_url = nil
    end
    if self.changed?
      self.save!
    else
      true
    end
  end

end
