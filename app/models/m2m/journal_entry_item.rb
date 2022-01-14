# == Schema Information
#
# Table name: gljeitem
#
#  fcentry          :char(10)         default("          "), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnorder          :integer          default(0), not null
#  fcacctno         :char(25)         default("                         "), not null
#  fctrsdes         :varchar_max(2147 default(""), not null
#  fndebit          :decimal(17, 5)   default(0.0), not null
#  fncredit         :decimal(17, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::JournalEntryItem < M2m::Base
  self.table_name = 'gljeitem'
  alias_date_attribute :date, :fddate
  alias_attribute :description, :fctrsdes
  alias_attribute :debit, :fndebit
  alias_attribute :credit, :fncredit
end
