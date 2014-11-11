# == Schema Information
#
# Table name: ocdist
#
#  fcacctnum        :string(25)       default(""), not null
#  fcomment         :string(45)       default(""), not null
#  fcrefclass       :string(1)        default(""), not null
#  fcrefname        :string(4)        default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fctime_ts        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcuser_id        :string(4)        default(""), not null
#  fdate            :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fjob_so          :string(15)       default(""), not null
#  fnamount         :decimal(17, 5)   default(0.0), not null
#  fpartno          :string(25)       default(""), not null
#  fcpartrev        :string(3)        default(""), not null
#  frcv_ship        :string(6)        default(""), not null
#  fcjosplt         :string(1)        default(""), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fneuroamt        :decimal(17, 5)   default(0.0), not null
#  fntxnamt         :decimal(17, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
#


class M2m::GlProductionPosting < M2m::Base
  self.table_name = 'ocdist'
  belongs_to :gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fcacctnum', :primary_key => 'fcacctnum'

  alias_attribute :amount, :fnamount

  def self.gl_account(gl_account)
  	gl_account = gl_account.account_number if gl_account.is_a?(M2m::GlAccount)
  	gl_account = gl_account.sub('-', '')
  	where :fcacctnum => gl_account
  end
  def self.gl_accounts(gl_accounts)
  	gl_accounts = gl_accounts.map { |a| a.is_a?(M2m::GlAccount) ? a.account_number.sub('-', '') : a.sub('-', '')}
  	where :fcacctnum => gl_accounts
  end

  # I have no idea if this is correct for anyone other than SMT.
  def self.inventory_issuances
  	self.gl_accounts(M2m::ProductClass.material_account_numbers).where(:fcrefname => 'INV')
  end
  def self.part_numbers(part_numbers)
  	where :fpartno => part_numbers
  end
end
