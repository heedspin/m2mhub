# == Schema Information
#
# Table name: gltran
#
#  fcacctnum        :char(25)         default("                         "), not null
#  fcrefclass       :char(2)          default("  "), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcuserid         :char(4)          default("    "), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ftrsamt          :money            default(0.0), not null
#  ftrsdes          :varchar_max(2147 default(""), not null
#  ftrsref          :char(10)         default("          "), not null
#  ftrsdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  feurotrsamt      :money            default(0.0), not null
#  ftxntrsamt       :money            default(0.0), not null
#  flreverse        :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmcocons         :varchar_max(2147 default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::GlTransaction < M2m::Base
  self.table_name = 'gltran'
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

  scope :post_dates, -> (start_date, end_date) {
    start_date = DateParser.parse(start_date) if start_date.is_a?(String)
    end_date = DateParser.parse(end_date) if end_date.is_a?(String)
      where ['gltran.fddate >= ? and gltran.fddate < ?', start_date, end_date ]
  }
  REFKEY_JOURNAL_ENTRY='JE'
  scope :journal_entries, -> { where(:fcrefclass => REFKEY_JOURNAL_ENTRY) }
  scope :gl_category, -> (category_code) {
    joins(:gl_account).
    where(:glmast => { :fccode => category_code })
  }
  # These are a bit of a mystery.  Could be "not_credit" and filter out M2m::AccountsReceivableSetup.customer_credit.
  scope :not_balance_entries, -> { where(['gltran.ftrsdes != ?', 'BALANCE A/R']) }
  scope :not_receivables_or_credits, -> {
    where ['gltran.fcacctnum not in (?)', [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ]
  }
  scope :revenue_receivables_and_credits, -> {
    joins(:gl_account).
    where(['glmast.fccode = ? or gltran.fcacctnum in (?)', 'R', [M2m::AccountsReceivableSetup.customer_credit, M2m::AccountsReceivableSetup.receivables] ])
  }
  scope :not_adjustments, -> {
    joins(:gl_account).
    where(['gltran.fcacctnum != ?', M2m::AccountsReceivableSetup.adjustment])
  }
  scope :with_ids, -> (ids) {
    where [ 'gltran.identity_column in (?)', ids ]
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
