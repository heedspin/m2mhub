# == Schema Information
#
# Table name: jolbck
#
#  fctrans_id       :string(10)       default(""), not null
#  fcjobno          :string(10)       default(""), not null
#  fnoperno         :integer          default(0), not null
#  fcpro_id         :string(7)        default(""), not null
#  fddate           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fnsethrs         :decimal(11, 4)   default(0.0), not null
#  fnprodhrs        :decimal(11, 4)   default(0.0), not null
#  fnulabcost       :decimal(17, 5)   default(0.0), not null
#  fnuovhdcost      :decimal(7, 2)    default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :binary
#  fac              :string(20)       default("")
#

class M2m::JobLabor < M2m::Base
  self.table_name = 'jolbck'
end
