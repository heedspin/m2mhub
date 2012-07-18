# == Schema Information
#
# Table name: gljeitem
#
#  fcentry          :string(10)      default(""), not null
#  fddate           :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fnorder          :integer(4)      default(0), not null
#  fcacctno         :string(25)      default(""), not null
#  fctrsdes         :string(30)      default(""), not null
#  fndebit          :decimal(17, 5)  default(0.0), not null
#  fncredit         :decimal(17, 5)  default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

class M2m::JournalEntryItem < M2m::Base
  set_table_name 'gljeitem'
  alias_date_attribute :date, :fddate
  alias_attribute :description, :fctrsdes
  alias_attribute :debit, :fndebit
  alias_attribute :credit, :fncredit
end
