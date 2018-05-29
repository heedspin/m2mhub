# == Schema Information
#
# Table name: glitem
#
#  fcacctnum        :string(25)       default(""), not null
#  fcclass          :string(1)        default(""), not null
#  fcdescr          :string(20)       default(""), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcuserid         :string(4)        default(""), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnamount         :decimal(, )      default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#

class M2m::GlItem < M2m::Base
  self.table_name = 'glitem'
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'
  def self.account_number(n)
    where :fcacctnum => n
  end
  def self.post_dates(start_date, end_date)
    start_date = Date.parse(start_date) if start_date.is_a?(String)
    end_date = Date.parse(end_date) if end_date.is_a?(String)
    where ['glitem.fddate >= ? and glitem.fddate < ?', start_date, end_date]
  end
  scope :class_date, where(:fcclass => 'D')
  alias_attribute :date, :fddate
  alias_attribute :amount, :fnamount
  alias_attribute :description, :fcdescr
end
