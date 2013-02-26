# == Schema Information
#
# Table name: sales_quotes
#
#  id              :integer          not null, primary key
#  quote_number    :integer
#  date            :date
#  customer_name   :string(255)
#  customer_id     :integer
#  recipient       :text
#  terms_id        :integer
#  other_terms     :string(255)
#  foreword        :text
#  postfix         :text
#  quote_status_id :integer
#  creator_id      :integer
#  approver_id     :integer
#  min_quote_price :decimal(12, 2)
#  max_quote_price :decimal(12, 2)
#  private_notes   :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Sales::Quote < M2mhub::Base
  set_table_name 'sales_quotes'
  has_many :items, :class_name => 'Sales::QuoteItem'
  validates_uniqueness_of :quote_number
  belongs_to_active_hash :status, :class_name => 'Sales::QuoteStatus', :foreign_key => :quote_status_id
  belongs_to :customer, :class_name => 'Sales::Customer'
  belongs_to_active_hash :terms, :class_name => 'Sales::Terms'

  scope :by_created_at_desc, :order => 'sales_quotes.created_at desc'
  
  def uniq_part_numbers
    @uniq_part_numbers ||= self.items.map(&:part_number).uniq.sort
  end
  
  def terms_string
    @terms_string ||= [self.terms.try(:name), self.other_terms].select(&:present?).join(' ').strip
  end
  
  STARTING_QUOTE_NUMBER=5000
  
  before_validation :set_quote_number, :on => :create
  def set_quote_number
    self.quote_number = (Sales::Quote.maximum(:quote_number) || STARTING_QUOTE_NUMBER) + 1
  end
  
  after_initialize :set_defaults
  def set_defaults
    begin
      self.status ||= Sales::QuoteStatus.unapproved
      self.foreword ||= AppConfig.sales_quote_default_foreword
      self.postfix ||= AppConfig.sales_quote_default_postfix
    rescue ActiveModel::MissingAttributeError
      # Ignore this exception.  Probably because we used a :select.
    rescue
      raise
    end
  end
  
  attr_accessor :current_user
  
  validate :customer_exists
  def customer_exists
    if self.customer.blank?
      errors.add(:customer_name, "Failed to find customer with name \"#{self.customer_name}\".")
    end
    true
  end
  
  before_validation :set_customer
  def set_customer
    if self.customer_name.present? and (self.customer_id.nil? or self.customer.nil? or (self.customer.name != self.customer_name))
      if self.customer_name_changed? 
        self.customer = Sales::Customer.with_name(self.customer_name).first
      elsif self.customer.present? # Customer record name changed.
        self.customer_name = self.customer.name          
      else
        self.customer_id = nil
      end
    end
    true
  end  
end
