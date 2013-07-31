# == Schema Information
#
# Table name: m2mhub_events
#
#  id                    :integer          not null, primary key
#  trigger_id            :integer
#  erp_type              :string(255)
#  erp_id                :integer
#  erp_number            :string(255)
#  lighthouse_ticket_id  :string(255)
#  lighthouse_project_id :string(255)
#  title                 :string(255)
#  user_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_status         :string(255)
#  closed                :boolean
#  ticket_url            :string(255)
#  body                  :text
#

require 'lighthouse_ticket'

class M2mhub::Event < M2mhub::Base
  self.table_name = 'm2mhub_events'
  belongs_to :trigger, :class_name => 'M2mhub::Trigger', :foreign_key => 'trigger_id'
  belongs_to :user
  belongs_to_lighthouse_ticket
  
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
  scope :valid, lambda {
    {
      :conditions => ['m2mhub_events.ticket_status != ?', Lighthouse::Ticket::STATE_INVALID]
    }
  }

  def create_ticket(title, body)
    self.lighthouse_ticket = Lighthouse::Ticket.new(:project_id => self.trigger.lighthouse_project_id)
    self.lighthouse_ticket.title = title
    self.lighthouse_ticket.body = body
    self.lighthouse_ticket.assigned_user_id = Rails.env.production? ? self.user.try(:lighthouse_user_id) : AppConfig.m2mhub_event_test_lighthouse_user_id
    self.lighthouse_ticket.watcher_ids = Rails.env.production? ? self.trigger.users.map(&:lighthouse_user_id) : []
    if self.lighthouse_ticket.save
      self.lighthouse_project_id = self.trigger.lighthouse_project_id
      self.lighthouse_ticket_id = self.lighthouse_ticket.id
      self.update_ticket_state
    else
      false
    end
  end
  
  def update_ticket_state
    self.closed = self.lighthouse_ticket.closed?
    self.ticket_status = self.lighthouse_ticket.state
    self.ticket_url = self.lighthouse_ticket.url
  end

  def update_status!
    if self.trigger.notification_type.ticket? and self.lighthouse_ticket
      self.update_ticket_state
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
