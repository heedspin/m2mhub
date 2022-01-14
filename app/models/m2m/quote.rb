# == Schema Information
#
# Table name: qtmast
#
#  fcompany         :varchar(35)      default(""), not null
#  fquoteno         :varchar(10)      default(""), not null, primary key
#  fackdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  fcfname          :char(15)         default("               "), not null
#  fcfromno         :varchar(25)      default(""), not null
#  fcfromtype       :char(5)          default("     "), not null
#  fcity            :char(20)         default("                    "), not null
#  fcountry         :char(25)         default("                         "), not null
#  fdatedue         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdaterecvd       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdcurdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdexpired        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdistno          :char(6)          default("      "), not null
#  fdsalespn        :char(25)         default("                         "), not null
#  fduplicate       :boolean          default(FALSE), not null
#  festimator       :char(3)          default("   "), not null
#  ffax             :char(20)         default("                    "), not null
#  fjobname         :varchar(65)      default(""), not null
#  fcsoldto         :varchar(6)       default(""), not null
#  fcustno          :char(6)          default("      "), not null
#  fnextenum        :char(3)          default("   "), not null
#  fnextinum        :char(3)          default("   "), not null
#  fordpotent       :char(1)          default(" "), not null
#  fordtime         :char(1)          default(" "), not null
#  fphone           :char(20)         default("                    "), not null
#  fprint_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fprinted         :boolean          default(FALSE), not null
#  fquotecopy       :char(1)          default(" "), not null
#  fquotedate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fquoteto         :char(20)         default("                    "), not null
#  frequestno       :char(15)         default("               "), not null
#  frevno           :char(2)          default("  "), not null
#  fsalespn         :char(3)          default("   "), not null
#  fstate           :char(20)         default("                    "), not null
#  fstatus          :char(20)         default("                    "), not null
#  ftype            :char(1)          default(" "), not null
#  fzip             :char(10)         default("          "), not null
#  fcusrchr1        :char(20)         default("                    "), not null
#  fcusrchr2        :varchar(40)      default(""), not null
#  fcusrchr3        :varchar(40)      default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdisrate         :decimal(15, 5)   default(0.0), not null
#  fterm            :char(4)          default("    "), not null
#  fpaytype         :char(1)          default(" "), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fusercode        :char(7)          default("       "), not null
#  fcshipto         :varchar(6)       default(""), not null
#  fltotal          :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null
#  fclosmemo        :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fmusermemo       :varchar_max(2147 default(""), not null
#  fsalumemo        :varchar_max(2147 default(""), not null
#  fndbrmod         :integer          default(0), not null
#  fccontkey        :char(10)         default("          "), not null
#  flcontract       :boolean          default(FALSE), not null
#  ContractNu       :varchar(10)      default(""), not null
#  OpportunNum      :varchar(10)      default(""), not null
#  ModifiedDate     :datetime         default(1900-01-01 00:00:00 UTC), not null
#  OppCrType        :char(3)          default("   "), not null
#  CreatedDate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fbilladdr        :varchar(6)       default(""), not null
#  contactnum       :varchar(6)       default(""), not null
#

class M2m::Quote < M2m::Base
  self.table_name = 'qtmast'
  self.primary_key = 'fquoteno'
  
  has_many :items, :class_name => 'M2m::QuoteItem', :foreign_key => :fquoteno, :primary_key => :fquoteno
  
  scope :status_open,      -> { where(:fstatus => M2m::Status.open.name) }
  scope :status_closed,    -> { where(:fstatus => M2m::Status.closed.name) }
  scope :status_cancelled, -> { where(:fstatus => M2m::Status.cancelled.name) }

  scope :by_quote_number_desc, -> { order('fquoteno desc') }

  scope :since, -> (day) {
    where(['qtmast.fquotedate >= ?', day]).order('fquotedate desc, fquoteno desc')
  }

  def terms
    M2m::Terms.find_by_key(self.fterm.try(:strip))
  end
  
  def customer_name
    M2m::Customer.customer_name(self.fcompany)
  end
  
  alias_attribute :discount_rate, :fdisrate
  alias_attribute :quote_number, :fquoteno
  alias_attribute :date, :fdcurdate
  alias_attribute :company_name, :fcompany
  alias_attribute :customer_number, :fcustno
  alias_attribute :contact_first_name, :fquoteto
  alias_attribute :contact_last_name, :fcfname
  alias_attribute :memo, :fclosmemo
  
  accepts_nested_attributes_for :items
  
  attr_accessor :contact_name
  def contact_name
    [(self.contact_first_name || '').titleize, (self.contact_last_name || '').capitalize].join(' ')
  end
  
  def self.pad_quote_number(txt)
    "%06d" % txt.to_i
  end
  
end
