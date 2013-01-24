class M2m::WorkCenter < M2m::Base
  set_table_name 'inwork'
  set_primary_key 'fcpro_id'
  
  alias_attribute :work_center_id, :fcpro_id
  alias_attribute :capacity_constraint, :flconstrnt
  
  scope :name_like, lambda { |names|
    likes = names.map { |n| "(inwork.fcpro_name like \'%#{n}%\')" }
    {
      :conditions => likes.join(" OR ")
    }
  }
  scope :work_center_ids, lambda { |ids|
    {
      :conditions => ['inwork.fcpro_id in (?)', ids]
    }
  }
  
  def name
    fcpro_name.titleize.strip
  end
  
  def short_name
    @short_name ||= self.name[0..2] + '-' + self.work_center_id
  end
  
  @@cache = {}  
  def self.cached_lookup(id)
    return nil unless id.present?
    @@cache[id] ||= M2m::WorkCenter.find(id)
  end
  
  
end

# == Schema Information
#
# Table name: inwork
#
#  fnavgwkhrs       :decimal(6, 2)   default(0.0), not null
#  fcpro_id         :string(7)       default(""), not null, primary key
#  fcpro_name       :string(16)      default(""), not null
#  fccomments       :string(54)      default(""), not null
#  fdept            :string(2)       default(""), not null
#  flabcost         :decimal(17, 5)  default(0.0), not null
#  fnavgque         :decimal(7, 1)   default(0.0), not null
#  flschedule       :boolean         default(FALSE), not null
#  fnmax1           :integer(4)      default(0), not null
#  fnmax2           :integer(4)      default(0), not null
#  fnmax3           :integer(4)      default(0), not null
#  fnmaxque         :decimal(7, 1)   default(0.0), not null
#  fnpctutil        :decimal(6, 1)   default(0.0), not null
#  fnqueallow       :decimal(8, 2)   default(0.0), not null
#  fnstd1           :integer(4)      default(0), not null
#  fnstd2           :integer(4)      default(0), not null
#  fnstd3           :integer(4)      default(0), not null
#  fnstd_prod       :decimal(11, 6)  default(0.0), not null
#  fnstd_set        :decimal(7, 2)   default(0.0), not null
#  fnsumdur         :decimal(9, 1)   default(0.0), not null
#  fovrhdcost       :decimal(17, 5)  default(0.0), not null
#  fscheduled       :string(1)       default(""), not null
#  fspandays        :integer(4)      default(0), not null
#  fnpque           :decimal(7, 1)   default(0.0), not null
#  flconstrnt       :boolean         default(FALSE), not null
#  identity_column  :integer(4)      not null
#  timestamp_column :binary
#  fac              :string(20)      default(""), not null
#  fcstdormax       :string(8)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#  fnloadcapc       :decimal(6, 2)   default(0.0), not null
#  fnmaxcapload     :decimal(4, 1)   default(0.0), not null
#  flaltset         :boolean         default(FALSE), not null
#  fcsyncmisc       :string(20)      default(""), not null
#  QueueHrs         :decimal(9, 2)   default(0.0), not null
#  ConstBuff        :decimal(5, 1)   default(0.0), not null
#  ResGroup         :string(15)      default(""), not null
#  flBFLabor        :boolean         default(FALSE), not null
#  CycleUnits       :decimal(13, 3)  default(0.0), not null
#  SimOpsType       :string(10)      default(""), not null
#  Size             :decimal(13, 3)  default(0.0), not null
#  CanBreak         :boolean         default(FALSE), not null
#  SizeUM           :string(3)       default("0"), not null
#

