# == Schema Information
#
# Table name: sales_opportunities
#
#  id                      :integer(4)      not null, primary key
#  start_date              :date
#  end_date                :date
#  customer_id             :string(255)
#  customer_name           :string(255)
#  amount                  :integer(4)
#  opportunity_source_id   :integer(4)
#  product                 :string(255)
#  title                   :string(255)
#  body                    :text
#  sales_person_id         :string(255)
#  sales_person_name       :string(255)
#  status_id               :integer(4)
#  wakeup                  :date
#  created_at              :datetime
#  updated_at              :datetime
#  creator_id              :integer(4)
#  last_comment_updated_id :integer(4)
#  sales_customer_id       :integer(4)
#

require 'plutolib/to_xls'

class Sales::Opportunity < M2mhub::Base
  set_table_name 'sales_opportunities'
  has_many :comments, :class_name => 'Sales::OpportunityComment', :foreign_key => :opportunity_id, :dependent => :destroy
  belongs_to_active_hash :source, :class_name => 'Sales::OpportunitySource', :foreign_key => :opportunity_source_id
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :primary_key => 'fsalespn'
  belongs_to_active_hash :status, :class_name => 'Sales::OpportunityStatus'
  belongs_to :sales_customer, :class_name => 'Sales::Customer', :foreign_key => 'sales_customer_id'
  belongs_to :last_comment, :class_name => 'Sales::OpportunityComment', :foreign_key => :last_comment_updated_id
  
  # validates_presence_of :customer_name

  attr_accessor :delete_permanently

  def number_and_title
    txt = self.title.present? ? self.title : self.customer_name
    "##{id} - #{txt}"
  end
  def full_sales_person
    @full_sales_person ||= [self.sales_person.try(:name), self.sales_person_name].compact.join(', ')
  end
  def sales_customer_name
    self.sales_customer.try(:name) || self.customer_name
  end

  scope :status, lambda { |s|
    s = s.id if s.is_a?(Sales::OpportunityStatus)
    {
      :conditions => { :status_id => s }
    }
  }
  scope :status_closed, :conditions => [ 'sales_opportunities.status_id in (?)', Sales::OpportunityStatus.all_closed.map(&:id) ]
  scope :status_open, :conditions => [ 'sales_opportunities.status_id in (?)', Sales::OpportunityStatus.all_open.map(&:id) ]
  scope :by_customer_name, :order => :customer_name
  scope :by_last_update_desc, :order => 'sales_opportunities.updated_at desc'
  scope :customer_name_like, lambda { |text|
    text = '%' + (text || '') + '%'
    {
      :include => :sales_customer,
      :conditions => [ 'sales_opportunities.customer_name like ? or (sales_customers.name like ?)', text, text ]
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
  scope :sales_territory, lambda { |sales_territory_id|
    {
      :joins => :sales_customer,
      :conditions => { :sales_customers => { :sales_territory_id => sales_territory_id } }
    }
  }

  before_save :set_customer
  def set_customer
    if self.customer_name.present? and (self.sales_customer_id.nil? or self.sales_customer.nil? or (self.sales_customer.name != self.customer_name))
      if (found = Sales::Customer.with_name(self.customer_name)) and (found.size == 1)
        self.sales_customer = found.first
        self.customer_name = self.sales_customer.name
      else
        self.sales_customer_id = nil
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
  
  def build_ticket_comment(ticket_created_by, lighthouse_assigned_user_id)
    comment = self.comments.build(:status_id => self.status_id, :comment_type_id => Sales::OpportunityCommentType.ticket.id)
    comment.lighthouse_project_id = AppConfig.opportunities_default_lighthouse_project_id
    comment.lighthouse_title = [self.product.try(:strip), self.title.try(:strip)].select(&:present?).join(' - ')
    lighthouse_body = [ ]
    
    # Filter out lines starting with M2MHub:
    self.body.split("\n").each do |line|
      unless line.starts_with?('M2MHub:')
        lighthouse_body.push line
      end
    end
    
    lighthouse_body.push "\n---"
    lighthouse_body.push "Ticket Created By: *#{ticket_created_by}*"
    url = Rails.application.routes.url_helpers.opportunity_url(self, :host => AppConfig.hostname)
    lighthouse_body.push "M2MHub Opportunity: [#{comment.lighthouse_title}](#{url})"
    comment.lighthouse_body = lighthouse_body.join("\n")
    comment.lighthouse_assigned_user_id = lighthouse_assigned_user_id
    comment.wakeup = self.wakeup || Date.current.advance(:days => 7)
    comment
  end

  class Export
    include Plutolib::ToXls
    def initialize(opportunities)
      @opportunities = opportunities
    end
    
    def xls_initialize
      xls_field("Start Date") { |o| o.start_date }
      xls_field('Customer') { |o| o.sales_customer_name }
      xls_field('Source') { |o| o.source.try(:name) }
      xls_field('Product') { |o| o.product }
      xls_field('Title') { |o| o.title }
      xls_field('Territory') { |o| o.sales_customer.try(:sales_territory).try(:name_and_description) }
      xls_field('Sales Rep') { |o| o.sales_customer.try(:sales_territory).try(:sales_rep_name) }
      xls_field('Location') { |o| o.sales_customer.try(:location) }
      xls_field('Business') { |o| o.sales_customer.try(:business_type).try(:name) }
      xls_field('Website') { |o| o.sales_customer.try(:website_url) }
      xls_field('Customer Notes') { |o| o.sales_customer.try(:notes) }
    end

    def all_data
      @opportunities
    end
  end
end
