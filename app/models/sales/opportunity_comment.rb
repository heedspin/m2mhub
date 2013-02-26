# == Schema Information
#
# Table name: sales_opportunity_comments
#
#  id                                 :integer          not null, primary key
#  opportunity_id                     :integer
#  comment_type_id                    :integer
#  status_id                          :integer
#  previous_status_id                 :integer
#  lighthouse_ticket_id               :string(255)
#  lighthouse_project_id              :string(255)
#  lighthouse_project_name            :string(255)
#  lighthouse_milestone               :string(255)
#  lighthouse_status                  :string(255)
#  lighthouse_closed                  :boolean
#  lighthouse_url                     :string(255)
#  lighthouse_title                   :string(255)
#  lighthouse_last_comment            :text
#  lighthouse_last_updated_at         :datetime
#  lighthouse_last_updater            :string(255)
#  lighthouse_last_assigned_user_name :string(255)
#  sales_order_id                     :string(255)
#  quote_id                           :string(255)
#  date                               :date
#  loss_reason_id                     :integer
#  wakeup                             :date
#  comment                            :text
#  created_at                         :datetime
#  updated_at                         :datetime
#  creator_id                         :integer
#

require 'm2mhub/lighthouse_watcher'

class Sales::OpportunityComment < M2mhub::Base
  set_table_name 'sales_opportunity_comments'
  include M2mhub::LighthouseWatcher
  
  belongs_to :opportunity, :class_name => 'Sales::Opportunity'
  belongs_to_active_hash :status, :class_name => 'Sales::OpportunityStatus', :foreign_key => :status_id
  belongs_to_active_hash :previous_status, :class_name => 'Sales::OpportunityStatus', :foreign_key => :previous_status_id
  belongs_to :creator, :class_name => 'User'
  belongs_to_active_hash :comment_type, :class_name => 'Sales::OpportunityCommentType', :foreign_key => :comment_type_id
  belongs_to_active_hash :loss_reason, :class_name => 'Sales::OpportunityLossReason', :foreign_key => :loss_reason_id
  belongs_to :quote, :class_name => 'M2m::Quote', :primary_key => 'fquoteno'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :primary_key => 'fsono'

  validates_presence_of :lighthouse_title, :if => lambda { |c| c.comment_type.try(:ticket?) }

  scope :by_id, :order => :id
  scope :open_tickets, :conditions => [ 'sales_opportunity_comments.comment_type_id = ? and sales_opportunity_comments.lighthouse_closed = ?', Sales::OpportunityCommentType.ticket.id, false ]
  scope :with_ticket, lambda { |ticket|
    ticket_id = ticket.is_a?(Lighthouse::Ticket) ? ticket.id : ticket
    {
      :conditions => [ 'sales_opportunity_comments.lighthouse_ticket_id = ?', ticket_id ]
    }
  }
  scope :to_monitor, :joins => :opportunity, :conditions => [ 'sales_opportunity_comments.comment_type_id = ? and sales_opportunities.status_id in (?)', Sales::OpportunityCommentType.ticket.id, Sales::OpportunityStatus.all_open.map(&:id)]
  
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
      self.opportunity.status_id = self.previous_status_id || Sales::OpportunityStatus.active
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
  
  before_create :handle_lighthouse
  def handle_lighthouse
    if self.create_lighthouse_ticket and self.lighthouse_ticket_id.nil? and self.lighthouse_project_id.present?
      self.lighthouse_watcher_create(self.lighthouse_title, self.lighthouse_body, self.lighthouse_assigned_user_id)
    elsif self.comment =~ /lighthouseapp.com\/projects\/(\d+)[^\/]*\/tickets\/(\d+)/
      # Import the ticket and change our comment type.
      project_id = $1
      ticket_id = $2
      if self.lighthouse_ticket = Lighthouse::Ticket.find(ticket_id, :params => { :project_id => project_id })
        self.lighthouse_ticket_id = ticket_id
        self.lighthouse_project_id = project_id
        self.lighthouse_watcher_update
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
  
  # Sales::OpportunityComment.to_monitor.each { |c| Sales::OpportunityComment.find(c.id).update_status! }
  def update_status!
    self.lighthouse_watcher_update
    if self.changed?
      self.save_without_timestamping!
    else
      true
    end
  end
  
  before_save :update_opportunity
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
  
  after_save :update_opportunity_updated_at
  def update_opportunity_updated_at
    if self.updated_at and (self.opportunity.updated_at < self.updated_at)
      self.opportunity.updated_at = self.updated_at
    end
    # self.opportunity.last_comment = self ; self.opportunity.save! ====> BOOOOM!!!!!!!!!!
    self.opportunity.last_comment_updated_id = self.id
    self.opportunity.save_without_timestamping!
  end
end
