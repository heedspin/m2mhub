# == Schema Information
#
# Table name: sales_opportunities
#
#  id                      :integer          not null, primary key
#  start_date              :date
#  end_date                :date
#  customer_id             :string(255)
#  customer_name           :string(255)
#  amount                  :integer
#  opportunity_source_id   :integer
#  product                 :string(255)
#  title                   :string(255)
#  body                    :text
#  sales_person_id         :string(255)
#  sales_person_name       :string(255)
#  status_id               :integer
#  wakeup                  :date
#  created_at              :datetime
#  updated_at              :datetime
#  creator_id              :integer
#  last_comment_updated_id :integer
#  sales_customer_id       :integer
#  owner_id                :integer
#  xnumber_decimal         :integer
#

require 'plutolib/to_xls'
require 'm2mhub_current_user'

# Sales::Opportunity.connection.execute 'create index opportunities_xnumber on sales_opportunities(xnumber_decimal)'
#

class Sales::Opportunity < M2mhub::Base
  self.table_name = 'sales_opportunities'
  has_many :comments, :class_name => 'Sales::OpportunityComment', :foreign_key => :opportunity_id, :dependent => :destroy
  belongs_to_active_hash :source, :class_name => 'Sales::OpportunitySource', :foreign_key => :opportunity_source_id
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :primary_key => 'fsalespn'
  belongs_to_active_hash :status, :class_name => 'Sales::OpportunityStatus'
  belongs_to :sales_customer, :class_name => 'Sales::Customer', :foreign_key => 'sales_customer_id'
  belongs_to :last_comment, :class_name => 'Sales::OpportunityComment', :foreign_key => :last_comment_updated_id
  accepts_nested_attributes_for :sales_customer
  belongs_to :owner, :class_name => 'User'
  has_many :quotes, :through => :comments, :class_name => 'Sales::Quote'
  has_many :display_logs, -> { where(log_type_id: Doogle::LogType.opportunity.id) }, class_name: 'Doogle::DisplayLog', foreign_key: :object_id
  validates_uniqueness_of :xnumber_decimal

  # Do not require customer name.  Web hits may not have them.
  # validates_presence_of :customer_name

  %w(quote sample_order tooling_order production_order).each do |key|
    self.class_eval <<-RUBY
      def last_#{key}
        if @last_#{key}_initialized.nil?
          @last_#{key}_initialized = true
          @last_#{key} = self.comments.by_created.#{key}s.last
        end
        @last_#{key}
      end
    RUBY
  end

  def total_sales_orders
    @total_sales_orders ||= self.comments.by_created.sales_orders.all.map(&:sales_order).compact.sum { |so| so.total_price || 0 }
  end

  attr_accessor :delete_permanently
  attr_accessor :create_customer
  def create_customer=(val)
    @create_customer = (val == '1')
  end

  def safe_title
    @safe_title ||= self.title.present? ? self.title : (self.customer_name.present? ? self.customer_name : "#{self.xnumber}: No Title")
  end
  def number_and_title
    "#{self.xnumber} - #{self.safe_title}"
  end
  def title_and_customer
    "#{self.safe_title} for #{self.customer_name}"
  end
  def full_sales_person
    @full_sales_person ||= [self.sales_person.try(:name), self.sales_person_name].compact.join(', ')
  end
  def sales_customer_name
    self.sales_customer.try(:name) || self.customer_name
  end
  def sales_rep_name
    @sales_rep_name ||= [self.sales_customer.sales_territory.try(:sales_rep_name), self.sales_person_name].join(': ')
  end
  def title_or_number
    self.title.present? ? self.title : self.xnumber
  end

  def self.status(s)
    s = Sales::OpportunityStatus.find(s) unless s.is_a?(Sales::OpportunityStatus)
    where ['sales_opportunities.status_id in (?)', s.children_ids]
  end
  scope :status_closed, -> { where([ 'sales_opportunities.status_id in (?)', Sales::OpportunityStatus.all_closed.map(&:id) ]) }
  scope :status_open, -> { where([ 'sales_opportunities.status_id in (?)', Sales::OpportunityStatus.all_open.map(&:id) ]) }
  scope :by_customer_name, -> { order(:customer_name) }
  scope :by_last_update_desc, -> { order('sales_opportunities.updated_at desc') }
  scope :by_amount_desc, -> { order('sales_opportunities.amount desc') }
  scope :customer_name_like, -> (text) {
    text = '%' + (text || '') + '%'
    joins(:sales_customer).
    where([ 'sales_opportunities.customer_name ilike ? or sales_customers.name ilike ?', text, text ])
  }
  scope :not_deleted, -> { where([ 'sales_opportunities.status_id != ?', Sales::OpportunityStatus.deleted.id ]) }
  def self.start_dates(start_date, end_date)
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where [ 'sales_opportunities.start_date >= ? and sales_opportunities.start_date < ?', start_date, end_date ]
  end
  def self.sales_territory(sales_territory_id)
    where(:sales_customers => { :sales_territory_id => sales_territory_id }).joins(:sales_customer)
  end
  def self.owner(owner)
    owner = owner.id if owner.is_a?(User)
    where(:owner_id => owner)
  end
  def self.rep_status(rep_status)
    where(:sales_customers => { :rep_status_id => rep_status.is_a?(Sales::RepStatus) ? rep_status.id : rep_status}).joins(:sales_customer)
  end
  def self.lead_level(lead_level)
    lead_level = Sales::LeadLevel::Search.find(lead_level) if (lead_level.is_a?(Fixnum) || lead_level.is_a?(String))
    where('sales_customers.lead_level_id in (?)', lead_level.lead_level_ids).joins(:sales_customer)
  end
  def self.source(source)
    where :opportunity_source_id => source.is_a?(Sales::OpportunitySource) ? source.id : source
  end
  def self.on_hold_until(date)
    where [ 'sales_opportunities.status_id = ? and sales_opportunities.wakeup <= ?', Sales::OpportunityStatus.hold, date]
  end
  def self.updated_before(date)
    where [ 'sales_opportunities.updated_at < ?', date ]
  end
  def self.win_type_search(win_type_search_id)
    joins(:comments).where([ 'sales_opportunity_comments.status_id = ? and sales_opportunity_comments.win_type_id in (?)', 
      Sales::OpportunityStatus.won, 
      Sales::OpportunityWinTypeSearch.find(win_type_search_id).win_type_ids])
  end

  # This logic is mostly duplicated in quote.
  before_save :set_customer
  def set_customer
    if !self.create_customer and self.customer_name.present? and (self.sales_customer_id.nil? or self.sales_customer.nil? or (self.sales_customer.name != self.customer_name))
      if (self.sales_customer_id.nil? and self.customer_name.present?) or self.customer_name_changed?
        self.sales_customer = Sales::Customer.with_name(self.customer_name).first
      elsif self.sales_customer.present? # Customer record name changed.
        self.customer_name = self.sales_customer.name
      else
        self.sales_customer_id = nil
      end
    end
    true
  end

  before_update :set_customer_rep_status
  def set_customer_rep_status
    if self.opportunity_source_id_changed? and self.source.try(:sales_rep?) and self.sales_customer and self.sales_customer.rep_status.try(:unknown?)
      self.sales_customer.update_attributes(:rep_status => Sales::RepStatus.connected)
    end
  end

  def part_numbers
    if self.product.present?
      self.product.split(/[ ,]+/)
    else
      []
    end
  end

  def all_referenced_part_numbers
    (self.comments.quotes.all.map { |c| c.quote.items.all.map(&:part_number) }.flatten + self.part_numbers).uniq.sort
  end

  def displays
    @displays ||= self.part_numbers.map { |pn| Doogle::Display.find_by_model_number(pn) }.compact
  end

  after_create :create_display_logs
  def create_display_logs
    self.part_numbers.each do |part_number|
      if display = Doogle::Display.find_by_model_number(part_number)
        display.logs.create( :log_type => Doogle::LogType.opportunity,
                             :object_id => self.id,
                             :user_id => M2mhubCurrentUser.user.try(:id),
                             :summary => 'Opportunity',
                             :event_time => self.created_at )
      end
    end
  end

  before_update :update_display_logs
  def update_display_logs
    if self.product_changed?
      self.display_logs.destroy_all
      self.create_display_logs
    end
  end

  after_destroy :destroy_display_logs
  def destroy_display_logs
    self.display_logs.destroy_all
  end

  def destroy(dp=nil)
    if dp || self.delete_permanently
      super()
    else
      self.status = Sales::OpportunityStatus.deleted
      self.save
    end
  end

  def guess_website
    if self.body =~ /From: [^@\n]+@([^@\n]+)/m
      domain = $1.strip
      if domain.starts_with?('www')
        domain
      else
        'www.' + domain
      end
    else
      nil
    end
  end

  class XNumber
    def self.test
      (0..1024000).each do |n|
        x1 = new(n)
        x2 = new(x1.to_s)
        puts "#{n} => #{x1.to_s}\t\t#{x1.to_s} => #{x2.to_i}"
        if n != x2.to_i
          puts "fail"
          break
        end
      end
    end
    def self.extract(string)
      if string =~ /X?([A-Z][A-Z])(\d+)/
        "X#{$1}#{$2}"
      else
        nil
      end
    end
    Alph = ("A".."Z").to_a
    def initialize(thing)
      if thing.nil?
      elsif thing.is_a?(String)
        @string = thing.upcase
        if @string =~ /^X?([A-Z][A-Z])(\d+)$/
          numbers = $2
          characters_power = numbers.try(:size) || 0
          @integer = numbers.present? ? numbers.to_i : 0
          characters = $1.reverse
          (0..(characters.size-1)).each do |i|
            @integer += (characters[i].ord - 65) * (26 ** i) * 10 ** characters_power
          end
        end
        @integer
      else
        @integer = thing
        if @integer == 0
          @string = 'XA'
        else
          # http://stackoverflow.com/questions/14632304/generate-letters-to-represent-number-using-ruby
          @string, q = '', @integer
          (q, r = q.divmod(q < 676 ? 26 : 10)) && @string.insert(0,(q < 26 ? Alph[r] : r.to_s)) until q.zero?
          @string.insert(0, 'X')
        end
      end
    end
    def to_i
      @integer
    end
    def to_s
      @string
    end
  end

  before_validation :set_xnumber, :on => :create
  def set_xnumber
    self.xnumber_decimal = (Sales::Opportunity.maximum(:xnumber_decimal) || 0) + 1
  end
  attr_accessor :xnumber
  def xnumber
    @xnumber ||= XNumber.new(self.xnumber_decimal).to_s
  end
  def self.xnumber(xnumber)
    where(:xnumber_decimal => XNumber.new(xnumber).to_i)
  end
  def self.with_parsed_xnumber(text)
    return where('true=true') unless text.present?
    where [ 'sales_opportunities.xnumber_decimal in (?)', text.scan(/x[a-z][a-z]\d+?/i).map { |xn| XNumber.new(xn).to_i } ]
  end
  def self.xnumbers(xnumbers)
    where [ 'sales_opportunities.xnumber_decimal in (?)', xnumbers.map { |xn| XNumber.new(xn).to_i } ]
  end

  def self.fill_in_xnumbers
    self.order(:id).each do |o|
      o.set_xnumber
      o.save!
    end
    true
  end

  class Export
    include Plutolib::ToXls
    def initialize(opportunities)
      @opportunities = opportunities
    end

    def xls_initialize
      xls_field("X Number") { |o| o.xnumber }
      xls_field("Status") { |o| o.status.name }
      xls_field("Date") { |o| o.start_date }
      xls_field('Customer') { |o| o.sales_customer_name }
      xls_field('Source') { |o| o.source.try(:name) }
      xls_field('Potential Revenue', xls_dollar_format) { |o| o.amount }
      xls_field('Title') { |o| o.title }
      xls_field('Product') { |o| o.product }
      xls_field('Location') { |o| o.sales_customer.try(:location) }
      xls_field('Sales Territory') { |o| o.sales_customer.try(:sales_territory).try(:name) }
      xls_field('Sales Company') { |o| o.sales_customer.try(:sales_territory).try(:sales_rep_name) }
      xls_field('Sales Person') { |o| o.sales_person_name }
      xls_field('Quote', xls_date_format) { |o| o.comments.by_created.all.detect { |c| c.comment_type.quote? }.try(:created_at) }
      xls_field('Sample Order', xls_date_format) { |o| o.comments.by_created.all.reverse.detect { |c| c.comment_type.sales_order? && c.win_type.try(:sample_order?) }.try(:created_at) }
      xls_field('Tooling Order', xls_date_format) { |o| o.comments.by_created.all.reverse.detect { |c| c.comment_type.sales_order? && c.win_type.try(:tooling_order?) }.try(:created_at) }
      xls_field('Production Order', xls_date_format) { |o| o.comments.by_created.all.reverse.detect { |c| c.comment_type.sales_order? && c.win_type.try(:production_order?) }.try(:created_at) }
      xls_field('Last Update', xls_date_format) { |o| o.comments.by_created.all.last.try(:created_at) }
      xls_field('Last Comment') { |o| o.comments.by_created.all.reverse.detect { |c| c.comment.present? }.try(:comment) }
    end

    def all_data
      @opportunities
    end
  end

  def self.run_notifications
    Sales::Opportunity.on_hold_until(Date.current).each(&:wakeup!)
    Sales::OpportunityComment.reminder_on(Date.current).each(&:send_reminder!)
  end

  def wakeup!
    self.update_attributes(:status => Sales::OpportunityStatus.active)
    Sales::OpportunityNotifier.wakeup_notifier(self).deliver
  end

  def self.run_reaper
    Sales::Opportunity.status(Sales::OpportunityStatus.active).updated_before(Date.current.advance(:months => -6)).each(&:expire!)
  end

  def expire!
    self.comments.create(:status_id => Sales::OpportunityStatus.lost.id,
                         :comment_type_id => Sales::OpportunityCommentType.lost.id,
                         :loss_reason_id => Sales::OpportunityLossReason.reaper.id,
                         :comment => "Opportunity has not been active since #{self.updated_at.to_s(:human_date)}")
  end

  after_create :send_new_opportunity_notification
  def send_new_opportunity_notification
    Sales::OpportunityNotifier.new_opportunity_notifier(self).deliver
  end
  
end
