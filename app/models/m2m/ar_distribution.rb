# == Schema Information
#
# Table name: ardist
#
#  fcacctnum        :string(25)      default(""), not null
#  fccashid         :string(35)      default(""), not null
#  fcstatus         :string(1)       default(""), not null
#  fcrefclass       :string(1)       default(""), not null
#  fcrefname        :string(4)       default(""), not null
#  fctime_ts        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcuserid         :string(4)       default(""), not null
#  fddate           :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnamount         :decimal(, )     default(0.0), not null
#  fccashnum        :string(20)      default(""), not null
#  fccurid          :string(3)       default(""), not null
#  fcfactor         :decimal(17, 5)  default(0.0), not null
#  feurofctr        :decimal(17, 5)  default(0.0), not null
#  fneuroamt        :decimal(, )     default(0.0), not null
#  fntxnamt         :decimal(, )     default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

class M2m::ArDistribution < M2m::Base
  set_table_name 'ardist'
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'

  alias_attribute :gl_account_number, :fcacctnum
  alias_attribute :amount, :fnamount

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
  scope :receivables_and_credits, lambda {
    {
      :conditions => ['ardist.fcacctnum in (?)', 
                      [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ]
    }
  }
  scope :not_receivables_or_credits, lambda {
    {
      :conditions => ['ardist.fcacctnum not in (?)', 
                      [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ]
    }
  }
  def document_id
    self.fccashid[7..17]
  end
  def customer_id
    self.fccashid[1..5]
  end
  def value
    self.amount * self.gl_account.value_multiplier
  end
end
