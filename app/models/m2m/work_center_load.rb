# == Schema Information
#
# Table name: dbrrlrp
#
#  cbatchname       :char(15)         default("               "), not null
#  noutstacum       :decimal(18, 3)   default(0.0), not null
#  userid           :varchar(30)      default(""), not null
#  perdname         :char(10)         default("          "), not null
#  req_load         :decimal(18, 3)   default(0.0), not null
#  capacity         :decimal(17, 1)   default(0.0), not null
#  nloadprcnt       :decimal(8, 1)    default(0.0), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  seqno            :integer          default(0), not null
#  fcpro_id         :char(7)          default("       "), not null
#  noutstacap       :decimal(18, 3)   default(0.0), not null
#  ncumcapprc       :decimal(8, 1)    default(0.0), not null
#  fcfac            :char(20)         default("                    ")
#  sortdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  SortDateSt       :char(19)         default("                   "), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::WorkCenterLoad < M2m::Base
  self.table_name = 'dbrrlrp'
  
  belongs_to :work_center, :class_name => 'M2m::WorkCenter', :foreign_key => :fcpro_id

  alias_attribute :work_center_id, :fcpro_id
  alias_attribute :work_load, :req_load
  
  scope :for_batch, -> (batch_name) {
    where(:cbatchname => batch_name).
    includes('work_center')
  }
  scope :with_load, -> { where('dbrrlrp.req_load > 0') }
  
  def date
    @date ||= Date.new(self.sortdate.year, self.sortdate.month, self.sortdate.day)
  end
  
  def load_percentage
    if (self.work_load <= 0) or self.capacity <= 0
      0
    else
      (self.work_load.to_f / self.capacity) * 100
    end
  end
end

