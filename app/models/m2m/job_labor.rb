# == Schema Information
#
# Table name: jolbck
#
#  fctrans_id       :char(10)         default("          "), not null
#  fcjobno          :varchar(20)      default(""), not null
#  fnoperno         :integer          default(0), not null
#  fcpro_id         :char(7)          default("       "), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnsethrs         :decimal(11, 4)   default(0.0), not null
#  fnprodhrs        :decimal(11, 4)   default(0.0), not null
#  fnulabcost       :decimal(17, 5)   default(0.0), not null
#  fnuovhdcost      :decimal(7, 2)    default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    ")
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::JobLabor < M2m::Base
  self.table_name = 'jolbck'
end
