# == Schema Information
#
# Table name: inrtgs
#
#  fpartno          :string(25)      default(""), not null
#  fcpartrev        :string(3)       default(""), not null
#  foperno          :integer(4)      default(0), not null
#  fchngrates       :string(1)       default(""), not null
#  fcstddesc        :string(4)       default(""), not null
#  felpstime        :decimal(12, 5)  default(0.0), not null
#  ffixcost         :decimal(17, 5)  default(0.0), not null
#  flschedule       :boolean         default(FALSE), not null
#  fmovetime        :decimal(8, 2)   default(0.0), not null
#  foperqty         :decimal(15, 5)  default(0.0), not null
#  fothrcost        :decimal(17, 5)  default(0.0), not null
#  fpro_id          :string(7)       default(""), not null
#  fsetuptime       :decimal(7, 2)   default(0.0), not null
#  fsubcost         :decimal(17, 5)  default(0.0), not null
#  fulabcost        :decimal(17, 5)  default(0.0), not null
#  fuovrhdcos       :decimal(17, 5)  default(0.0), not null
#  fuprodtime       :decimal(16, 10) default(0.0), not null
#  fusubcost        :decimal(17, 5)  default(0.0), not null
#  fllotreqd        :boolean         default(FALSE), not null
#  fccharcode       :string(10)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fopermemo        :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  fcudrev          :string(3)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#  fnsimulops       :integer(4)      default(0), not null
#  fyield           :decimal(12, 5)  default(100.0), not null
#  fsetyield        :decimal(8, 2)   default(0.0), not null
#  flBFLabor        :boolean         default(FALSE), not null
#  CycleUnits       :decimal(13, 3)  default(0.0), not null
#  UnitSize         :decimal(13, 3)  default(0.0), not null
#

class M2m::DefaultRouteOperation < M2m::Base
  set_table_name 'inrtgs'

  has_one :work_center, :class_name => 'M2m::WorkCenter', :primary_key => 'fpro_id', :foreign_key => 'fcpro_id'
  
  alias_attribute :operation_number, :foperno
  alias_attribute :work_center_id, :fpro_id
  alias_attribute :operation_memo, :fopermemo
  
  scope :item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fcpartrev => item.revision }
    }
  }
  scope :work_center_ids, lambda { |work_centers|
    {
      :conditions => [ 'inrtgs.fpro_id in (?)', work_centers ]
    }
  }
  scope :work_centers, lambda { |work_centers|
    work_center_ids = work_centers.map(&:work_center_id)
    {
      :conditions => [ 'inrtgs.fpro_id in (?)', work_center_ids ]
    }
  }
end
