# == Schema Information
#
# Table name: sales_opportunity_comments
#
#  id                                 :integer(4)      not null, primary key
#  opportunity_id                     :integer(4)
#  comment_type_id                    :integer(4)
#  status_id                          :integer(4)
#  previous_status_id                 :integer(4)
#  lighthouse_ticket_id               :string(255)
#  lighthouse_project_id              :string(255)
#  lighthouse_project_name            :string(255)
#  lighthouse_milestone               :string(255)
#  lighthouse_status                  :string(255)
#  lighthouse_closed                  :boolean(1)
#  lighthouse_url                     :string(255)
#  lighthouse_title                   :string(255)
#  lighthouse_last_comment            :text
#  lighthouse_last_updated_at         :datetime
#  lighthouse_last_updater            :string(255)
#  lighthouse_last_assigned_user_name :string(255)
#  sales_order_id                     :string(255)
#  quote_id                           :string(255)
#  date                               :date
#  loss_reason_id                     :integer(4)
#  wakeup                             :date
#  comment                            :text
#  created_at                         :datetime
#  updated_at                         :datetime
#  creator_id                         :integer(4)
#

class Sales::OpportunityComment < M2mhub::Base
  set_table_name 'sales_opportunity_comments'
  
  belongs_to :opportunity, :class_name => 'Sales::Opportunity'
  belongs_to_active_hash :status, :class_name => 'Sales::OpportunityStatus', :foreign_key => :status_id
  belongs_to_active_hash :previous_status, :class_name => 'Sales::OpportunityStatus', :foreign_key => :previous_status_id
  belongs_to :creator, :class_name => 'User'
  belongs_to_lighthouse_ticket
  belongs_to_lighthouse_project
  belongs_to_active_hash :comment_type, :class_name => 'Sales::OpportunityCommentType', :foreign_key => :comment_type_id
  belongs_to_active_hash :loss_reason, :class_name => 'Sales::OpportunityLossReason', :foreign_key => :loss_reason_id
  belongs_to :quote, :class_name => 'M2m::Quote', :primary_key => 'fquoteno'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :primary_key => 'fsono'

  scope :by_id, :order => :id
  scope :open_tickets, :conditions => [ 'sales_opportunity_comments.comment_type_id = ? and sales_opportunity_comments.lighthouse_closed = ?', Sales::OpportunityCommentType.ticket.id, false ]
  scope :with_ticket, lambda { |ticket|
    ticket_id = ticket.is_a?(Lighthouse::Ticket) ? ticket.id : ticket
    {
      :conditions => [ 'sales_opportunity_comments.lighthouse_ticket_id = ?', ticket_id ]
    }
  }
  scope :to_monitor, :joins => :opportunity, :conditions => [ 'sales_opportunity_comments.comment_type_id = ? and sales_opportunities.status_id in (?)', Sales::OpportunityCommentType.ticket.id, Sales::OpportunityStatus.open.map(&:id)]
  
  attr_accessor :create_lighthouse_ticket
  attr_accessor :lighthouse_assigned_user_id
  attr_accessor :lighthouse_body
  attr_accessor :delete_lighthouse_ticket
  
  def destroy
    if self.comment_type.try(:ticket?) and self.lighthouse_ticket and self.delete_lighthouse_ticket
      self.lighthouse_ticket.destroy
    end
    if next_last_comment = self.opportunity.comments.where(['sales_opportunity_comments.id != ?', self.id]).order('sales_opportunity_comments.id desc').first
      next_last_comment.update_opportunity
    else
      self.opportunity.status_id = self.previous_status_id
      self.opportunity.save!
    end
    super
  end
  
  def status_change?
    self.status_id != self.previous_status_id
  end 
  
  def ticket?
    self.comment_type.try(:ticket?)
  end
  
  before_create :update_opportunity
  def update_opportunity
    if self.status_id != self.opportunity.status_id
      self.previous_status_id = self.opportunity.status_id
      self.opportunity.status_id = self.status_id
    end
    if self.status.hold? and self.wakeup
      self.opportunity.wakeup = self.wakeup
    end
    if self.status.won? or self.status.lost? or (self.status.active? and (self.sales_order_id or self.quote_id))
      self.opportunity.end_date = self.date || self.created_at
    end
    self.opportunity.save! if self.opportunity.changed?
    true
  end

  before_create :handle_lighthouse
  def handle_lighthouse
    if self.create_lighthouse_ticket and self.lighthouse_ticket_id.nil? and self.lighthouse_project_id.present?
      self.lighthouse_ticket = Lighthouse::Ticket.new(:project_id => self.lighthouse_project_id)
      self.lighthouse_ticket.title = self.lighthouse_title
      self.lighthouse_ticket.body = self.lighthouse_body
      self.lighthouse_ticket.assigned_user_id = self.lighthouse_assigned_user_id if self.lighthouse_assigned_user_id
      if self.lighthouse_ticket.save
        self.lighthouse_ticket_id = self.lighthouse_ticket.id
        self.update_ticket_state
      else
        false
      end
    elsif self.comment =~ /lighthouseapp.com\/projects\/(\d+)[^\/]*\/tickets\/(\d+)/
      # Import the ticket and change our comment type.
      project_id = $1
      ticket_id = $2
      if self.lighthouse_ticket = Lighthouse::Ticket.find(ticket_id, :params => { :project_id => project_id })
        self.lighthouse_ticket_id = ticket_id
        self.lighthouse_project_id = project_id
        self.update_ticket_state
        self.comment_type = Sales::OpportunityCommentType.ticket
        # Ignore any status settings.
        self.status_id = self.opportunity.status_id
      end
    else
      true
    end
  end
  
  before_save :pad_quote_and_sales_numbers
  def pad_quote_and_sales_numbers
    if self.status.active?
      self.quote_id = M2m::Quote.pad_quote_number(self.quote_id) if self.quote_id.present?
    elsif self.status.won?
      self.sales_order_id = M2m::SalesOrder.pad_sales_order_number(self.sales_order_id) if self.sales_order_id.present?
    end
    true
  end
  
  def update_ticket_state
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

  # Sales::OpportunityComment.to_monitor.each { |c| Sales::OpportunityComment.find(c.id).update_status! }
  def update_status!
    # Bypass readonly exception.
    self.update_ticket_state
    if self.changed?
      self.save_without_timestamping!
    else
      true
    end
  end
  
  after_save :update_opportunity
  def update_opportunity
    if self.opportunity.updated_at < self.updated_at
      self.opportunity.updated_at = self.updated_at
    end
    self.opportunity.last_comment = self
    self.opportunity.save_without_timestamping!
  end
end
