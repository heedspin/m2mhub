class Lighthouse::Ticket
  attr_accessor :user_options
  
  def self.from_rma(rma, current_user)
    ticket = Lighthouse::Ticket.new(:project_id => AppConfig.lighthouse_rma_project_id)
    ticket.title = rma.customer_name.strip + ': ' + rma.items.first.try(:part_number)
    ticket.body = rma.items.first.try(:reason)
    # There's some problem with milestones, so hard code for now...
    ticket.milestone_id = AppConfig.lighthouse_rma_milestone_id
    ticket.user_options = Lighthouse::Project.find(AppConfig.lighthouse_rma_project_id).memberships.map { |m| [m.user.name, m.user.id] }.uniq.sort_by(&:first)
    if user = ticket.user_options.detect { |u| u.first == current_user.full_name }
      user_id = user.last
      ticket.assigned_user_id = user_id
      ticket.creator_id = user_id
    end
    ticket
  end
  
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
  
  def watcher_ids=(value)
    attributes['multiple_watchers'] = value
  end
  
  def closed?
    ['resolved', 'invalid'].include?(self.state)
  end

  ######################################
  # Trick formtastic:
  def new_record?
    false
  end
end
