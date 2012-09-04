# == Schema Information
#
# Table name: sales_opportunities
#
#  id                    :integer(4)      not null, primary key
#  start_date            :date
#  end_date              :date
#  customer_id           :string(255)
#  customer_name         :string(255)
#  amount                :integer(4)
#  opportunity_source_id :integer(4)
#  product               :string(255)
#  title                 :string(255)
#  body                  :text
#  sales_person_id       :string(255)
#  sales_person_name     :string(255)
#  status_id             :integer(4)
#  wakeup                :date
#  created_at            :datetime
#  updated_at            :datetime
#  creator_id            :integer(4)
#

class Sales::Opportunity < M2mhub::Base
  set_table_name 'sales_opportunities'
  has_many :comments, :class_name => 'Sales::OpportunityComment', :foreign_key => :opportunity_id, :dependent => :destroy
  belongs_to_active_hash :source, :class_name => 'Sales::OpportunitySource', :foreign_key => :opportunity_source_id
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :primary_key => 'fsalespn'
  belongs_to_active_hash :status, :class_name => 'Sales::OpportunityStatus'
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => :customer_id, :primary_key => :identity_column

  attr_accessor :delete_permanently

  def number_and_title
    "##{id} - #{title}"
  end
  def full_sales_person
    @full_sales_person ||= [self.sales_person.try(:name), self.sales_person_name].compact.join(', ')
  end

  scope :status, lambda { |s|
    s = s.id if s.is_a?(Sales::OpportunityStatus)
    {
      :conditions => { :status_id => s }
    }
  }
  scope :by_customer_name, :order => :customer_name
  scope :customer_name_like, lambda { |text|
    {
      :conditions => [ 'sales_opportunities.customer_name like ?', '%' + (text || '') + '%' ]
    }
  }
  scope :not_deleted, :conditions => [ 'sales_opportunities.status_id != ?', Sales::OpportunityStatus.deleted.id ]
  scope :start_dates, lambda { |start_date, end_date|
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'sales_opportunities.start_date >= ? and sales_opportunities.start_date < ?', start_date, end_date ]
    }
  }

  before_save :set_customer
  def set_customer
    if self.customer_name.present? and (self.customer_id.nil? or self.customer.nil? or (self.customer.name != self.customer_name))
      if found = M2m::Customer.name_like(self.customer_name).first
        self.customer_id = found.id
        self.customer_name = self.customer.name
      end
    end
    true
  end

  def destroy(dp=nil)
    if dp || self.delete_permanently
      super()
    else
      self.status = Sales::OpportunityStatus.deleted
      self.save
    end
  end

  # Sales::Opportunity.import_from_lighthouse
  def self.import_from_lighthouse(project_id=nil)
    project_id ||= AppConfig.opportunities_default_lighthouse_project_id
    page = 0
    while true
      tickets = Lighthouse::Ticket.find(:all, :params => { :q => 'all', :page => page, :project_id => project_id })
      tickets.each do |ticket|
        if Sales::OpportunityComment.with_ticket(ticket).count > 0
          puts "Skipping #{ticket.id}"
        else
          # Reload ticket to load versions.
          Sales::OpportunityFromTicket.create_opportunity(ticket.reload)
        end
      end
      break if tickets.size == 0
      page += 1
    end
    true
  end
end
