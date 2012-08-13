class M2m::Customer < M2m::Base
  set_table_name 'slcdpmx'

  has_many :sales_orders, :class_name => 'M2m::SalesOrder', :foreign_key => :fcustno, :primary_key => 'fcustno'
  has_many :quotes, :class_name => 'M2m::Quote', :foreign_key => :fcustno, :primary_key => 'fcustno'
  has_many :contacts, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fcustno', :conditions => { :fcs_alias => 'SLCDPM' }
  has_one :primary_contact, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fcustno', :conditions => { :fcs_alias => 'SLCDPM', :IsPrimary => true }
  has_many :addresses, :class_name => 'M2m::Address', :foreign_key => 'fcaliaskey', :primary_key => 'fcustno', :conditions => { :fcalias => 'SLCDPM' }
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
  alias_attribute :commission_percentage, :fsalcompct
  alias_attribute :created_date, :fcreated

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

  scope :name_like, lambda { |text|
    {
      :conditions => [ 'slcdpmx.fcompany like ?', '%' + (text || '') + '%' ]
    }
  }

  scope :by_name, :order => 'fcompany'

  scope :with_customer_numbers, lambda { |customer_numbers|
    {
      :conditions => [ 'slcdpmx.fcustno in (?)', customer_numbers ]
    }
  }
  scope :with_customer_number, lambda { |custno|
    {
      :conditions => { :fcustno => M2m::Customer.fcustno_for(custno) }
    }
  }
  scope :created_between, lambda { |start_date, end_date|
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'slcdpmx.fcreated >= ? and slcdpmx.fcreated < ?', start_date, end_date ]
    }
  }

  def status
    M2m::CustomerStatus.find_by_key(self.fcstatus)
  end

  def self.customer_name(txt)
    if (txt =~ /[a-z]/)
      txt
    else
      txt.split(' ').map { |p| p.downcase.capitalize }.join(' ')
    end
  end

  def name
    @name ||= M2m::Customer.customer_name(self.fcompany)
  end

  def self.all_names
    self.all(:select => 'slcdpmx.fcompany', :order => 'slcdpmx.fcompany').map(&:name)
  end

  def fob
    self.ffob.strip
  end

  validates_uniqueness_of :fcompany
  validates_presence_of :first_name, :last_name, :fcompany

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

  after_save :after_save_madness
  def after_save_madness
    unless @running_after_save_madness
      begin
        @running_after_save_madness = true
        need_to_save_self = false
        if self.fcustno.blank?
          self.fcustno = self.id
          need_to_save_self = true
        end
        contact = self.primary_contact || self.contacts.primary.new
        soldto = self.addresses.sold_to.first
        if soldto.nil?
          soldto = self.addresses.sold_to.new
          soldto.set_fcaddrkey
        end
        shipto = self.addresses.ship_to.first
        if shipto.nil?
          shipto = self.addresses.ship_to.new
          shipto.set_fcaddrkey
        end
        # self.addresses << address
        %w(first_name last_name work_email work_phone notes work_fax work_address work_city work_state work_postal_code work_country_name).each do |a|
          contact.send("#{a}=", self.send(a))
          soldto.send("#{a}=", self.send(a))
          shipto.send("#{a}=", self.send(a))
        end
        soldto.company_name = self.company_name
        shipto.company_name = self.company_name
        unless self.fcsoldto.present?
          self.fcsoldto = soldto.fcaddrkey
          need_to_save_self = true
        end
        unless self.fcshipto.present?
          self.fcshipto = shipto.fcaddrkey
          need_to_save_self = true
        end
        unless self.contact_number.present?
          self.contact_number = contact.contact_number
          need_to_save_self = true
        end
        contact.save! if contact.changed?
        soldto.save! if soldto.changed?
        shipto.save! if shipto.changed?
        self.save! if need_to_save_self
      rescue
        raise $!
      ensure
        @running_after_save_madness = false
      end
    end
    true
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

end




# == Schema Information
#
# Table name: slcdpmx
#
#  fcustno          :string(6)       default(""), not null
#  fcompany         :string(35)      default(""), not null
#  fcity            :string(20)      default(""), not null
#  fphone           :string(20)      default(""), not null
#  fann_sales       :integer(4)      default(0), not null
#  fbacklog         :decimal(16, 4)  default(0.0), not null
#  fbalnxt          :decimal(17, 5)  default(0.0), not null
#  fcfname          :string(15)      default(""), not null
#  fcontact         :string(20)      default(""), not null
#  fcountry         :string(25)      default(""), not null
#  fcreated         :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcrlimit         :integer(4)      default(0), not null
#  fcshipto         :string(4)       default(""), not null
#  fcsoldto         :string(4)       default(""), not null
#  fcurrency        :string(3)       default(""), not null
#  fcusrchr1        :string(20)      default(""), not null
#  fcusrchr2        :string(40)      default(""), not null
#  fcusrchr3        :string(40)      default(""), not null
#  fdbdate          :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdbrate          :string(4)       default(""), not null
#  fdisrate         :decimal(8, 3)   default(0.0), not null
#  fdistno          :string(6)       default(""), not null
#  fdusrdate1       :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fllongdist       :boolean         default(FALSE), not null
#  ffax             :string(20)      default(""), not null
#  ffincharge       :boolean         default(FALSE), not null
#  ffob             :string(20)      default(""), not null
#  fmtdamtnxt       :decimal(17, 5)  default(0.0), not null
#  fmtdsamt         :decimal(17, 5)  default(0.0), not null
#  fnardayslt       :decimal(17, 5)  default(0.0), not null
#  fno_employ       :integer(4)      default(0), not null
#  fcpaydex         :string(3)       default(""), not null
#  fnusrcur1        :decimal(17, 5)  default(0.0), not null
#  fnusrqty1        :decimal(15, 5)  default(0.0), not null
#  fpaytype         :string(1)       default(""), not null
#  fpriority        :string(2)       default(""), not null
#  fsalcompct       :decimal(8, 3)   default(0.0), not null
#  fsalespn         :string(3)       default(""), not null
#  fsicno1          :string(4)       default(""), not null
#  fsicno2          :string(4)       default(""), not null
#  fshipvia         :string(20)      default(""), not null
#  fsince           :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fstate           :string(20)      default(""), not null
#  ftaxcode         :string(10)      default(""), not null
#  ftaxexempt       :string(15)      default(""), not null
#  ftaxrate         :decimal(7, 3)   default(0.0), not null
#  fterm            :string(4)       default(""), not null
#  fterr            :string(10)      default(""), not null
#  ftype            :string(1)       default(""), not null
#  fusercode        :string(7)       default(""), not null
#  fytdsamt         :decimal(16, 4)  default(0.0), not null
#  fyr_estab        :string(4)       default(""), not null
#  fzip             :string(10)      default(""), not null
#  fcstatus         :string(1)       default(""), not null
#  flistaxabl       :boolean         default(FALSE), not null
#  fcemail          :string(60)      default(""), not null
#  flisfcast        :boolean         default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fbus_type        :text            default(""), not null
#  fmnotes          :text            default(""), not null
#  fmstreet         :text            default(""), not null
#  fmusrmemo1       :text            default(""), not null
#  fncrmmod         :integer(4)      default(0), not null
#  fccrmacct        :string(12)      default(""), not null
#  fscmprty         :integer(4)      default(4), not null
#  fdisttype        :string(10)      default("Email"), not null
#  SubType          :string(15)      default(""), not null
#  flEdited         :boolean         default(FALSE), not null
#  fURL             :string(255)     default(""), not null
#  ContactNum       :string(6)       default(""), not null
#  HomePhone        :string(20)      default(""), not null
#  MobilePhone      :string(20)      default(""), not null
#  NAICsCode        :string(6)       default(""), not null
#

