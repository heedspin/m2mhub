# == Schema Information
#
# Table name: sales_customers
#
#  id                 :integer          not null, primary key
#  parent_company_id  :integer
#  erp_customer_id    :string(255)
#  name               :string(255)
#  location           :text
#  sales_territory_id :integer
#  sales_person_id    :string(255)
#  sales_person_name  :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  business_type_id   :integer
#  notes              :text
#  website            :string(255)
#  lead_level_id      :integer
#  rep_status_id      :integer
#

class Sales::Customer < M2mhub::Base
  self.table_name = 'sales_customers'
  belongs_to :parent_company, :class_name => 'Sales::ParentCompany'
  belongs_to :erp_customer, :class_name => 'M2m::Customer', :foreign_key => 'erp_customer_id'
  belongs_to :sales_territory, :class_name => 'Sales::Territory'
  validates_uniqueness_of :name
  validates_uniqueness_of :erp_customer_id, :allow_blank => true
  validates_uniqueness_of :website, :allow_blank => true
  has_many :opportunities, :class_name => 'Sales::Opportunity', :foreign_key => 'sales_customer_id'
  belongs_to_active_hash :business_type, :class_name => 'Sales::BusinessType'
  belongs_to_active_hash :lead_level, :class_name => 'Sales::LeadLevel'
  belongs_to_active_hash :rep_status, :class_name => 'Sales::RepStatus'
  has_many :quotes, :class_name => 'Sales::Quote'
  
  attr_accessor :opportunity_id
  attr_accessor :parent_company_name
  attr_accessor :erp_customer_name
  def erp_customer_name
    @erp_customer_name ||= self.erp_customer.try(:name)
  end

  scope :name_like, lambda { |txt|
    {
      :conditions => [ 'sales_customers.name like ?', "%#{txt}%" ]
    }
  }
  scope :with_name, lambda { |txt|
    {
      :conditions => [ 'sales_customers.name = ?', txt ]
    }
  }
  scope :by_name, :order => :name
  scope :sales_territory, lambda { |sales_territory|
    where(:sales_territory_id => sales_territory.is_a?(Sales::Territory) ? sales_territory.id : sales_territory)
  }
  scope :rep_status, lambda { |rep_status|
    where(:rep_status_id => rep_status.is_a?(Sales::RepStatus) ? rep_status.id : rep_status)
  }
  scope :lead_level, lambda { |lead_level|
    lead_level = Sales::LeadLevel::Search.find(lead_level) if (lead_level.is_a?(Fixnum) || lead_level.is_a?(String))
    where(['lead_level_id in (?)', lead_level.lead_level_ids])
  }
  
  before_save :set_erp_customer
  def set_erp_customer
    if self.erp_customer_name.present? and (self.erp_customer_id.nil? or self.erp_customer.nil? or (self.erp_customer.name != self.erp_customer_name))
      if (found = M2m::Customer.with_name(self.erp_customer_name)) and (found.size == 1)
        self.erp_customer = found.first
      end
    end
    true
  end
  
  def attached_opportunity
    if @attached_opportunity.nil? and self.opportunity_id.present?
      @attached_opportunity = Sales::Opportunity.find_by_id(self.opportunity_id.to_i)
    end
    @attached_opportunity
  end
  
  after_create :attach_to_opportunity
  def attach_to_opportunity
    if self.attached_opportunity
      self.attached_opportunity.update_attributes(:sales_customer_id => self.id, :customer_name => self.name)
    end
  end
  
  def destroy
    Sales::Opportunity.update_all({:sales_customer_id => nil}, {:sales_customer_id => self.id})
    super
  end
  
  def website_url
    @website_url ||= if self.website.present? and !self.website.starts_with?('http')
      'http://' + self.website
    else
      self.website
    end
  end
  
  ::M2m::Address
  class ::M2m::Address < M2m::Base
    def city_state_country
      @city_state_country ||= [[self.work_city.strip, self.work_state.strip].select(&:present?).join(', '), self.work_country_name.strip].select(&:present?).join("\n")
    end
  end

  def self.import_from_erp_customer(erp_customer)
    sales_customer = Sales::Customer.where(:erp_customer_id => erp_customer.id).first || new(:erp_customer_id => erp_customer.id)
    sales_customer.name = erp_customer.name
    sales_customer.location = erp_customer.addresses.sold_to.first.try(:city_state_country)
    new_record = sales_customer.new_record?
    sales_customer.save!
    if new_record
      puts "Created company: #{sales_customer.name}"
    else
      puts "Updated company: #{sales_customer.name}"
    end
    sales_customer
  end
  
  def self.set_rep_status
    total_set = 0
    Sales::Opportunity.source(Sales::OpportunitySource.sales_rep).where('sales_opportunities.sales_customer_id is not null').each do |opportunity|
      if opportunity.sales_customer.rep_status.unknown?
        opportunity.sales_customer.update_attributes(:rep_status => Sales::RepStatus.connected)
        total_set += 1
      end
    end
    total_set
  end
end
