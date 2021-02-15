# == Schema Information
#
# Table name: ardist
#
#  fcacctnum        :string(25)       default(""), not null
#  fccashid         :string(35)       default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fcrefclass       :string(1)        default(""), not null
#  fcrefname        :string(4)        default(""), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcuserid         :string(4)        default(""), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnamount         :decimal(, )      default(0.0), not null
#  fccashnum        :string(20)       default(""), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fneuroamt        :decimal(, )      default(0.0), not null
#  fntxnamt         :decimal(, )      default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#

class M2m::ArDistribution < M2m::Base
  self.table_name = 'ardist'
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'

  alias_attribute :gl_account_number, :fcacctnum
  alias_attribute :amount, :fnamount
  alias_attribute :date, :fddate
  alias_attribute :ref_key, :fcrefname
  alias_attribute :status, :fcstatus

  scope :dates, -> (start_date, end_date) {
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
    where([ '[ardist].[fddate] >= ? and [ardist].[fddate] < ?', start_date, end_date ])
  }
  scope :gl_category, -> (category_code) {
    joins(:gl_account).
    where({ :glmast => { :fccode => category_code } })
  }
  scope :not_cash, -> { where('[ardist].[fcrefname] <> \'CSH\'') }
  scope :non_zero, -> { where('[ardist].[fnamount] != 0') }
  scope :with_ids, -> (ids) {
    where [ '[ardist].[identity_column] in (?)', ids ]
  }
  def self.gl_description_like(text)
    joins(:gl_account).where(['[glmast].[fcdescr] like ?', '%' + text + '%'])
  end
  
  def posted?
    self.status == 'P'
  end
  def unposted?
    self.status == 'U'
  end
  def never_posted?
    self.status == 'N'
  end
  
  def ref_id
    self.fccashid[7..17]
  end
  def ref_invoice?
    self.ref_key.strip == 'INV'
  end
  attr_accessor :invoice
  def invoice
    @invoice ||= self.ref_invoice? && M2m::Invoice.invoice_number(self.ref_id).first
  end
  def invoice_number
    self.ref_invoice? ? self.ref_id : nil
  end
  
  def customer_number
    self.fccashid[1..6]
  end
  attr_accessor :customer
  def customer
    @customer ||= M2m::Customer.with_customer_number(self.customer_number).first
  end
  def value
    self.never_posted? ? 0 : (self.amount * self.gl_account.value_multiplier)
  end
end
