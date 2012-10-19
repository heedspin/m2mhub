# == Schema Information
#
# Table name: inrtgc
#
#  fpartno          :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  fbatch01         :integer(4)      default(0), not null
#  fbatch02         :integer(4)      default(0), not null
#  fbatch03         :integer(4)      default(0), not null
#  fbatch04         :integer(4)      default(0), not null
#  fbatch05         :integer(4)      default(0), not null
#  fbatch06         :integer(4)      default(0), not null
#  fbatch07         :integer(4)      default(0), not null
#  fbatch08         :integer(4)      default(0), not null
#  fbatch09         :integer(4)      default(0), not null
#  fbatch10         :integer(4)      default(0), not null
#  fbatch11         :integer(4)      default(0), not null
#  fbatch12         :integer(4)      default(0), not null
#  ffixcost         :decimal(17, 5)  default(0.0), not null
#  flabcost         :decimal(17, 5)  default(0.0), not null
#  fmax01           :decimal(15, 5)  default(0.0), not null
#  fmax02           :decimal(15, 5)  default(0.0), not null
#  fmax03           :decimal(15, 5)  default(0.0), not null
#  fmax04           :decimal(15, 5)  default(0.0), not null
#  fmax05           :decimal(15, 5)  default(0.0), not null
#  fmax06           :decimal(15, 5)  default(0.0), not null
#  fmax07           :decimal(15, 5)  default(0.0), not null
#  fmax08           :decimal(15, 5)  default(0.0), not null
#  fmax09           :decimal(15, 5)  default(0.0), not null
#  fmax10           :decimal(15, 5)  default(0.0), not null
#  fmax11           :decimal(15, 5)  default(0.0), not null
#  fmax12           :decimal(15, 5)  default(0.0), not null
#  fothrcost        :decimal(17, 5)  default(0.0), not null
#  fovrhdcos        :decimal(17, 5)  default(0.0), not null
#  fqty01           :decimal(15, 5)  default(0.0), not null
#  fqty02           :decimal(15, 5)  default(0.0), not null
#  fqty03           :decimal(15, 5)  default(0.0), not null
#  fqty04           :decimal(15, 5)  default(0.0), not null
#  fqty05           :decimal(15, 5)  default(0.0), not null
#  fqty06           :decimal(15, 5)  default(0.0), not null
#  fqty07           :decimal(15, 5)  default(0.0), not null
#  fqty08           :decimal(15, 5)  default(0.0), not null
#  fqty09           :decimal(15, 5)  default(0.0), not null
#  fqty10           :decimal(15, 5)  default(0.0), not null
#  fqty11           :decimal(15, 5)  default(0.0), not null
#  fqty12           :decimal(15, 5)  default(0.0), not null
#  frev_date        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fsetuplabc       :decimal(17, 5)  default(0.0), not null
#  fsetupovrc       :decimal(17, 5)  default(0.0), not null
#  fsetuptime       :decimal(14, 5)  default(0.0), not null
#  fspq             :decimal(15, 5)  default(0.0), not null
#  fstdrtg          :string(1)       default(""), not null
#  fsubcost         :decimal(17, 5)  default(0.0), not null
#  ftottime         :decimal(14, 5)  default(0.0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#

class M2m::DefaultRoute < M2m::Base
  set_table_name 'inrtgc'
end
