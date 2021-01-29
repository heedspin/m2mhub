# == Schema Information
#
# Table name: slcdpmx
#
#  fcustno          :string(6)        default(""), not null
#  fcompany         :string(35)       default(""), not null
#  fcity            :string(20)       default(""), not null
#  fphone           :string(20)       default(""), not null
#  fann_sales       :integer          default(0), not null
#  fbacklog         :decimal(16, 4)   default(0.0), not null
#  fbalnxt          :decimal(17, 5)   default(0.0), not null
#  fcfname          :string(15)       default(""), not null
#  fcontact         :string(20)       default(""), not null
#  fcountry         :string(25)       default(""), not null
#  fcreated         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcrlimit         :integer          default(0), not null
#  fcshipto         :string(4)        default(""), not null
#  fcsoldto         :string(4)        default(""), not null
#  fcurrency        :string(3)        default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fdbdate          :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdbrate          :string(4)        default(""), not null
#  fdisrate         :decimal(8, 3)    default(0.0), not null
#  fdistno          :string(6)        default(""), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fllongdist       :boolean          default(FALSE), not null
#  ffax             :string(20)       default(""), not null
#  ffincharge       :boolean          default(FALSE), not null
#  ffob             :string(20)       default(""), not null
#  fmtdamtnxt       :decimal(17, 5)   default(0.0), not null
#  fmtdsamt         :decimal(17, 5)   default(0.0), not null
#  fnardayslt       :decimal(17, 5)   default(0.0), not null
#  fno_employ       :integer          default(0), not null
#  fcpaydex         :string(3)        default(""), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fpaytype         :string(1)        default(""), not null
#  fpriority        :string(2)        default(""), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fsalespn         :string(3)        default(""), not null
#  fsicno1          :string(4)        default(""), not null
#  fsicno2          :string(4)        default(""), not null
#  fshipvia         :string(20)       default(""), not null
#  fsince           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fstate           :string(20)       default(""), not null
#  ftaxcode         :string(10)       default(""), not null
#  ftaxexempt       :string(15)       default(""), not null
#  ftaxrate         :decimal(7, 3)    default(0.0), not null
#  fterm            :string(4)        default(""), not null
#  fterr            :string(10)       default(""), not null
#  ftype            :string(1)        default(""), not null
#  fusercode        :string(7)        default(""), not null
#  fytdsamt         :decimal(16, 4)   default(0.0), not null
#  fyr_estab        :string(4)        default(""), not null
#  fzip             :string(10)       default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fcemail          :string(60)       default(""), not null
#  flisfcast        :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fbus_type        :text             default(""), not null
#  fmnotes          :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fmusrmemo1       :text             default(""), not null
#  fncrmmod         :integer          default(0), not null
#  fccrmacct        :string(12)       default(""), not null
#  fscmprty         :integer          default(4), not null
#  fdisttype        :string(10)       default("Email"), not null
#  SubType          :string(15)       default(""), not null
#  flEdited         :boolean          default(FALSE), not null
#  fURL             :string(255)      default(""), not null
#  ContactNum       :string(6)        default(""), not null
#  HomePhone        :string(20)       default(""), not null
#  MobilePhone      :string(20)       default(""), not null
#  NAICsCode        :string(6)        default(""), not null
#

class M2m::Customer < M2m::Base
  include M2m::CachedAddresses
  self.table_name = 'slcdpmx'

  has_many :sales_orders, :class_name => 'M2m::SalesOrder', :foreign_key => :fcustno, :primary_key => 'fcustno'
  has_many :quotes, :class_name => 'M2m::Quote', :foreign_key => :fcustno, :primary_key => 'fcustno'
  has_many :contacts, -> { where(fcs_alias: 'SLCDPM') }, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fcustno'
  has_one :primary_contact, -> { where(fcs_alias: 'SLCDPM', IsPrimary: true) }, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fcustno'
  has_many :addresses, -> { where(fcalias: 'SLCDPM') }, :class_name => 'M2m::Address', :foreign_key => 'fcaliaskey', :primary_key => 'fcustno'
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :foreign_key => 'fsalespn', :primary_key => 'fsalespn'

  alias_attribute :notes, :fmnotes
  alias_attribute :last_name, :fcontact
  alias_attribute :first_name, :fcfname
  alias_attribute :company_name, :fcompany
  alias_attribute :customer_number, :fcustno
  alias_attribute :work_email, :fcemail
  alias_attribute :work_phone, :fphone
  alias_attribute :work_notes, :fmnotes
  alias_attribute :work_fax, :ffax
  alias_attribute :work_address, :fmstreet
  alias_attribute :work_city, :fcity
  alias_attribute :work_state, :fstate
  alias_attribute :work_postal_code, :fzip
  alias_attribute :work_country_name, :fcountry
  alias_attribute :sales_person_key, :fsalespn
  # alias_attribute :commission_percentage, :fsalcompct
  alias_attribute :created_date, :fcreated
  alias_attribute :territory_code, :fterr

  after_initialize :set_defaults
  def set_defaults
    begin
      self.work_country_name = AppConfig.default_country_name if self.work_country_name.blank?
      # TODO: do something meaningful with ftype.
      self.ftype = 'C' if self.ftype.blank?
      # fcshipto => '0001', :fcsoldto => '0001'
      # SubType = 'NONE'
      # ContactNum = '000123'
    rescue ActiveModel::MissingAttributeError
      # Ignore this exception.  Probably because we used a :select.
    end
  end
  scope :name_like, -> (text) {
    where [ 'slcdpmx.fcompany like ?', '%' + (text || '') + '%' ]
  }
  scope :with_names, -> (names) {
    where [ 'slcdpmx.fcompany in (?)', names ]
  }
  scope :with_name, -> (txt) {
    where [ 'slcdpmx.fcompany = ?', txt ]
  }
  scope :by_name, -> { order(:fcompany) }

  scope :with_customer_numbers, -> (customer_numbers) {
    where [ 'slcdpmx.fcustno in (?)', customer_numbers ]
  }
  scope :with_customer_number, -> (custno) {
    where :fcustno => M2m::Customer.fcustno_for(custno)
  }
  scope :created_between, -> (start_date, end_date) {
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where [ 'slcdpmx.fcreated >= ? and slcdpmx.fcreated < ?', start_date, end_date ]
  }

  def status
    M2m::CustomerStatus.find_by_key(self.fcstatus)
  end

  def self.customer_name(txt)
    if (txt =~ /[a-z]/)
      txt
    else
      safe_titleize txt
    end
  end

  def name
    @name ||= M2m::Customer.customer_name(self.fcompany)
  end

  def fob
    self.ffob.strip
  end

  # validates_uniqueness_of :fcompany
  # validates_presence_of :first_name, :last_name, :fcompany

  before_save :update_timestamps
  def update_timestamps
    now = Time.now
    if self.new_record?
      write_attribute(:fcreated, now)
      write_attribute(:fsince, now) unless self.fsince.present?
    end
  end

  m2m_id_setter :fcustno, 6
  m2m_id_setter :fcshipto, 4
  m2m_id_setter :fcsoldto, 4
  m2m_id_setter :ContactNum, 6, :contact_number
  
  def sales_territory
    @sales_territory ||= M2m::SalesTerritory.cached_lookup(self.territory_code)
  end

  def self.data_to_params(data, params)
    hash = JSON.parse ActiveSupport::Base64.decode64(CGI.unescape(data))
    hash.each do |key, value|
      if key == 'company'
        params[:fcompany] = value
        # Rails.logger.debug("Decoded company: #{value}")
      elsif key == 'name'
        if value.present?
          fn, ln = value.split(' ', 2)
          params[:first_name] = fn
          params[:last_name] = ln
          # Rails.logger.debug("Decoded firstname: #{fn}")
          # Rails.logger.debug("Decoded lastname: #{ln}")
        end
      elsif key == 'email'
        params[:work_email] = value
        # Rails.logger.debug("Decoded email: #{value}")
      elsif key == 'phone'
        params[:work_phone] = value
        # Rails.logger.debug("Decoded phone: #{value}")
      end
    end
  end

  def self.pad_customer_number(txt)
    "%06d" % txt.to_i
  end

  def self.attach_customers(objects, customers=nil)
    customers ||= M2m::Customer.with_customer_numbers(objects.map(&:customer_number).uniq)
    customers_hash = {}
    customers.each { |c| customers_hash[c.customer_number] = c }
    result = []
    objects.each do |o|
      if found = customers_hash[o.customer_number]
        result.push o.customer = found
      else
        # Explicitly set this to keep it from trying to lazy load.
        o.customer = nil
      end
    end
    result
  end
end



