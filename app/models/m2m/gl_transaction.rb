# == Schema Information
#
# Table name: gltran
#
#  fcacctnum        :string(25)       default(""), not null
#  fcrefclass       :string(2)        default(""), not null
#  fctime_ts        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcuserid         :string(4)        default(""), not null
#  fddate           :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ftrsamt          :decimal(, )      default(0.0), not null
#  ftrsdes          :string(30)       default(""), not null
#  ftrsref          :string(10)       default(""), not null
#  ftrsdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  feurotrsamt      :decimal(, )      default(0.0), not null
#  ftxntrsamt       :decimal(, )      default(0.0), not null
#  flreverse        :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmcocons         :text             default(""), not null
#

class M2m::GlTransaction < M2m::Base
  set_table_name 'gltran'
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'

  alias_attribute :post_date, :fddate
  alias_attribute :transaction_date, :ftrsdate
  alias_attribute :ref_key, :fcrefclass
  alias_attribute :ref_id, :ftrsref
  alias_attribute :amount, :ftrsamt
  alias_attribute :description, :ftrsdes
  alias_attribute :gl_account_number, :fcacctnum
  alias_attribute :updated_at, :fctime_ts
  alias_attribute :reverse, :flreverse

  scope :post_dates, lambda { |start_date, end_date|
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    {
      :conditions => [ 'gltran.fddate >= ? and gltran.fddate < ?', start_date, end_date ]
    }
  }
  REFKEY_JOURNAL_ENTRY='JE'
  scope :journal_entries, :conditions => { :fcrefclass => REFKEY_JOURNAL_ENTRY }
  scope :gl_category, lambda { |category_code|
    {
      :joins => :gl_account,
      :conditions => { :glmast => { :fccode => category_code } }
    }
  }
  # These are a bit of a mystery.  Could be "not_credit" and filter out M2m::AccountsReceivableSetup.customer_credit.
  scope :not_balance_entries, :conditions => ['gltran.ftrsdes != ?', 'BALANCE A/R']
  scope :not_receivables_or_credits, lambda {
    {
      :conditions => ['gltran.fcacctnum not in (?)', 
                      [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ]
    }
  }
  scope :revenue_receivables_and_credits, lambda {
    {
      :joins => :gl_account,
      :conditions => ['glmast.fccode = ? or gltran.fcacctnum in (?)', 'R',
                      [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ]
    }
  }
  scope :not_adjustments, lambda {
    {
      :joins => :gl_account,
      :conditions => ['gltran.fcacctnum != ?', M2m::AccountsReceivableSetup.adjustment]
    }
  }
  scope :ids, lambda { |ids|
    {
      :conditions => [ 'gltran.identity_column in (?)', ids ]
    }
  }
  
  def ref_object
    @ref_object ||= case self.ref_key
    when REFKEY_JOURNAL_ENTRY
      M2m::JournalEntry.entry_id(self.ref_id).first
    end
  end
  def value
    self.amount * self.gl_account.value_multiplier
  end
  def journal_entry?
    self.ref_key == REFKEY_JOURNAL_ENTRY
  end
end
