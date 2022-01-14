# == Schema Information
#
# Table name: inrtgs
#
#  fpartno          :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  foperno          :integer          default(0), not null
#  fchngrates       :char(1)          default(" "), not null
#  fcstddesc        :char(4)          default("    "), not null
#  felpstime        :decimal(12, 5)   default(0.0), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  flschedule       :boolean          default(FALSE), not null
#  fmovetime        :decimal(8, 2)    default(0.0), not null
#  foperqty         :decimal(15, 5)   default(0.0), not null
#  fothrcost        :decimal(17, 5)   default(0.0), not null
#  fpro_id          :char(7)          default("       "), not null
#  fsetuptime       :decimal(7, 2)    default(0.0), not null
#  fsubcost         :decimal(17, 5)   default(0.0), not null
#  fulabcost        :decimal(17, 5)   default(0.0), not null
#  fuovrhdcos       :decimal(17, 5)   default(0.0), not null
#  fuprodtime       :decimal(16, 10)  default(0.0), not null
#  fusubcost        :decimal(17, 5)   default(0.0), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fccharcode       :char(10)         default("          "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fopermemo        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  fndbrmod         :integer          default(0), not null
#  fnsimulops       :integer          default(0), not null
#  fyield           :decimal(12, 5)   default(100.0), not null
#  fsetyield        :decimal(8, 2)    default(0.0), not null
#  flBFLabor        :boolean          default(FALSE), not null
#  CycleUnits       :decimal(13, 3)   default(0.0), not null
#  UnitSize         :decimal(13, 3)   default(0.0), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::DefaultRouteOperation < M2m::Base
  self.table_name = 'inrtgs'

  has_one :work_center, :class_name => 'M2m::WorkCenter', :primary_key => 'fpro_id', :foreign_key => 'fcpro_id'
  
  alias_attribute :operation_number, :foperno
  alias_attribute :work_center_id, :fpro_id
  alias_attribute :operation_memo, :fopermemo
  
  scope :item, -> (item) {
    where :fpartno => item.part_number, :fcpartrev => item.revision
  }
  scope :work_center_ids, -> (work_centers) {
    where [ 'inrtgs.fpro_id in (?)', work_centers ]
  }
  scope :work_centers, -> (work_centers) {
    work_center_ids = work_centers.map(&:work_center_id)
    where [ 'inrtgs.fpro_id in (?)', work_center_ids ]
  }
end
