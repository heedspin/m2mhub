class M2m::WorkCenter < M2m::Base
  set_table_name 'inwork'
  set_primary_key 'fcpro_id'
  
  alias_attribute :work_center_id, :fcpro_id
  alias_attribute :capacity_constraint, :flconstrnt
  
  def name
    fcpro_name.titleize.strip
  end
end
# == Schema Information
#
# Table name: inwork
#
#  fnavgwkhrs       :decimal(6, 2)   not null
#  fcpro_id         :string(7)       not null, primary key
#  fcpro_name       :string(16)      not null
#  fccomments       :string(54)      default(" "), not null
#  fdept            :string(2)       not null
#  flabcost         :decimal(7, 2)   not null
#  fnavgque         :decimal(7, 1)   not null
#  flschedule       :boolean         not null
#  fnmax1           :integer         not null
#  fnmax2           :integer         not null
#  fnmax3           :integer         not null
#  fnmaxque         :decimal(7, 1)   not null
#  fnpctutil        :decimal(6, 1)   not null
#  fnqueallow       :decimal(8, 2)   not null
#  fnstd1           :integer         not null
#  fnstd2           :integer         not null
#  fnstd3           :integer         not null
#  fnstd_prod       :decimal(11, 6)  not null
#  fnstd_set        :decimal(7, 2)   not null
#  fnsumdur         :decimal(9, 1)   not null
#  fovrhdcost       :decimal(7, 2)   not null
#  fscheduled       :string(1)       not null
#  fspandays        :integer         not null
#  fnpque           :decimal(7, 1)   not null
#  flconstrnt       :boolean         not null
#  identity_column  :integer(4)      not null
#  timestamp_column :binary
#  fac              :string(20)      not null
#  fcstdormax       :string(8)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#  fnloadcapc       :decimal(6, 2)   default(0.0), not null
#  fnmaxcapload     :decimal(4, 1)   not null
#  flaltset         :boolean         not null
#  fcsyncmisc       :string(20)      not null
#

