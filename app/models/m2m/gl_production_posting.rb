# == Schema Information
#
# Table name: ocdist
#
#  fcacctnum        :char(25)         default("                         "), not null
#  fcomment         :varchar_max(2147 default(""), not null
#  fcrefclass       :char(1)          default(" "), not null
#  fcrefname        :char(4)          default("    "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fctime_ts        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcuser_id        :varchar(35)      default(""), not null
#  fdate            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fjob_so          :varchar(20)      default(""), not null
#  fnamount         :decimal(17, 5)   default(0.0), not null
#  fpartno          :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  frcv_ship        :varchar(10)      default(""), not null
#  fcjosplt         :char(1)          default(" "), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fneuroamt        :decimal(17, 5)   default(0.0), not null
#  fntxnamt         :decimal(17, 5)   default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fdtrandate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frcv_shipItmno   :varchar(6)       default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
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
