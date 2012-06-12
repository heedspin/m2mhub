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
#  m2mhub_summary        :string(255)
#  user_id               :integer(4)
#  created_at            :datetime
#  updated_at            :datetime
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
  
  def create_ticket(project_id, title, body)
    @ticket = Lighthouse::Ticket.new(:project_id => project_id)
    @ticket.title = title
    @ticket.body = body
    @ticket.assigned_user_id = self.user.try(:lighthouse_user_id)
    if @ticket.save
      self.lighthouse_project_id = project_id
      self.lighthouse_ticket_id = ticket.id
    else
      false
    end
  end
  
  def resolved?
    self.trigger.notification_type.ticket? && self.ticket && self.ticket.closed?
  end

end
