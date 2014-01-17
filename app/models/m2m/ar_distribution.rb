# == Schema Information
#
# Table name: ardist
#
#  fcacctnum        :string(25)       default(""), not null
#  fccashid         :string(35)       default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fcrefclass       :string(1)        default(""), not null
#  fcrefname        :string(4)        default(""), not null
#  fctime_ts        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcuserid         :string(4)        default(""), not null
#  fddate           :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
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

  scope :dates, lambda { |start_date, end_date|
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'ardist.fddate >= ? and ardist.fddate < ?', start_date, end_date ]
    }
  }
  scope :gl_category, lambda { |category_code|
    {
      :joins => :gl_account,
      :conditions => { :glmast => { :fccode => category_code } }
    }
  }
  scope :not_cash, :conditions => 'ardist.fcrefname <> \'CSH\''
  scope :non_zero, :conditions => 'ardist.fnamount != 0'
  scope :ids, lambda { |ids|
    {
      :conditions => [ 'ardist.identity_column in (?)', ids ]
    }
  }
  
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
  def invoice
    @invoice ||= self.ref_invoice? && M2m::Invoice.invoice_number(self.ref_id).first
  end
  
  def customer_id
    self.fccashid[1..6]
  end
  def customer
    @customer ||= M2m::Customer.with_customer_number(self.customer_id).first
  end
  def value
    self.never_posted? ? 0 : (self.amount * self.gl_account.value_multiplier)
  end
end
