# == Schema Information
#
# Table name: qtmast
#
#  fcompany         :string(35)       default(""), not null
#  fquoteno         :string(6)        default(""), not null, primary key
#  fackdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  fcfname          :string(15)       default(""), not null
#  fcfromno         :string(6)        default(""), not null
#  fcfromtype       :string(5)        default(""), not null
#  fcity            :string(20)       default(""), not null
#  fcountry         :string(25)       default(""), not null
#  fdatedue         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdaterecvd       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdcurdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdexpired        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdistno          :string(6)        default(""), not null
#  fdsalespn        :string(25)       default(""), not null
#  fduplicate       :boolean          default(FALSE), not null
#  festimator       :string(3)        default(""), not null
#  ffax             :string(20)       default(""), not null
#  fjobname         :string(65)       default(""), not null
#  fcsoldto         :string(4)        default(""), not null
#  fcustno          :string(6)        default(""), not null
#  fnextenum        :string(3)        default(""), not null
#  fnextinum        :string(3)        default(""), not null
#  fordpotent       :string(1)        default(""), not null
#  fordtime         :string(1)        default(""), not null
#  fphone           :string(20)       default(""), not null
#  fprint_dt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fprinted         :boolean          default(FALSE), not null
#  fquotecopy       :string(1)        default(""), not null
#  fquotedate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fquoteto         :string(20)       default(""), not null
#  frequestno       :string(15)       default(""), not null
#  frevno           :string(2)        default(""), not null
#  fsalespn         :string(3)        default(""), not null
#  fstate           :string(20)       default(""), not null
#  fstatus          :string(20)       default(""), not null
#  ftype            :string(1)        default(""), not null
#  fzip             :string(10)       default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdisrate         :decimal(15, 5)   default(0.0), not null
#  fterm            :string(4)        default(""), not null
#  fpaytype         :string(1)        default(""), not null
#  fdeurodate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fusercode        :string(7)        default(""), not null
#  fcshipto         :string(4)        default(""), not null
#  fltotal          :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fclosmemo        :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fmusermemo       :text             default(""), not null
#  fsalumemo        :text             default(""), not null
#  fccontkey        :string(10)       default(""), not null
#  flcontract       :boolean          default(FALSE), not null
#  fndbrmod         :integer          default(0), not null
#  ContractNu       :string(10)       default(""), not null
#  OpportunNum      :string(6)        default(""), not null
#  ModifiedDate     :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  OppCrType        :string(3)        default(""), not null
#  CreatedDate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fbilladdr        :string(4)        default(""), not null
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
