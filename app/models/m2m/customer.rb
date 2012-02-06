class M2m::Customer < M2m::Base
  set_table_name 'slcdpmx'
  set_primary_key 'fcustno'
  has_many :sales_orders, :class_name => 'M2m::SalesOrder', :foreign_key => :fcustno
  has_many :quotes, :class_name => 'M2m::Quote', :foreign_key => :fcustno
  has_many :contacts, :class_name => 'M2m::Contact', :foreign_key => :fcsourceid, :primary_key => 'fcustno', :conditions => { :fcs_alias => 'slcdpm' }
  accepts_nested_attributes_for :contacts
  
  alias_attribute :notes, :fmnotes
  alias_attribute :last_name, :fcontact
  alias_attribute :first_name, :fcfname
  alias_attribute :company_name, :fcompany
  alias_attribute :customer_number, :fcustno
  
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
  
  validates_presence_of :fcompany
  
  before_save :update_timestamps
  def update_timestamps
    now = Time.now
    if self.new_record?
      write_attribute(:fcreated, now)
      write_attribute(:fsince, now) unless self.fsince.present?
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

