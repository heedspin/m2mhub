# == Schema Information
#
# Table name: gljemast
#
#  fcentry          :string(10)      default(""), not null
#  fddate           :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flreverse        :boolean         default(FALSE), not null
#  fcstatus         :string(1)       default(""), not null
#  flrecur          :boolean         default(FALSE), not null
#  flreventry       :boolean         default(FALSE), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#

class M2m::JournalEntry < M2m::Base
  set_table_name 'gljemast'
  has_many :items, :class_name => 'M2m::JournalEntryItem', :foreign_key => 'fcentry', :primary_key => 'fcentry'
  
  alias_attribute :entry_id, :fcentry
  scope :entry_id, lambda { |ei| { :conditions => { :fcentry => ei } } }
end
