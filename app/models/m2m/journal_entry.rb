# == Schema Information
#
# Table name: gljemast
#
#  fcentry          :char(10)         default("          "), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flreverse        :boolean          default(FALSE), not null
#  fcstatus         :char(1)          default(" "), not null
#  flrecur          :boolean          default(FALSE), not null
#  flreventry       :boolean          default(FALSE), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::JournalEntry < M2m::Base
  self.table_name = 'gljemast'
  has_many :items, :class_name => 'M2m::JournalEntryItem', :foreign_key => 'fcentry', :primary_key => 'fcentry'
  
  alias_attribute :entry_id, :fcentry
  scope :entry_id, -> (ei) { where(:fcentry => ei) }
end
