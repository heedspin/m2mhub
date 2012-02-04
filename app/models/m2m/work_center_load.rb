class M2m::WorkCenterLoad < M2m::Base
  set_table_name 'dbrrlrp'
  
  belongs_to :work_center, :class_name => 'M2m::WorkCenter', :foreign_key => :fcpro_id

  alias_attribute :work_center_id, :fcpro_id
  alias_attribute :work_load, :req_load
  
  scope :for_batch, lambda { |batch_name|
    {
      :conditions => { :cbatchname => batch_name },
      :include => 'work_center'
    }
  }
  scope :with_load, :conditions => 'dbrrlrp.req_load > 0'
  
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


# == Schema Information
#
# Table name: dbrrlrp
#
#  fcpro_id         :string(7)       default(""), not null
#  perdname         :string(10)      default(""), not null
#  req_load         :decimal(18, 3)  default(0.0), not null
#  capacity         :decimal(17, 1)  default(0.0), not null
#  nloadprcnt       :decimal(8, 1)   default(0.0), not null
#  noutstacap       :decimal(18, 3)  default(0.0), not null
#  ncumcapprc       :decimal(8, 1)   default(0.0), not null
#  noutstacum       :decimal(18, 3)  default(0.0), not null
#  cbatchname       :string(15)      default(""), not null
#  userid           :string(30)      default(""), not null
#  seqno            :integer(4)      default(0), not null
#  identity_column  :integer(4)      not null, primary key
#  timestamp_column :binary
#  fcfac            :string(20)      default("")
#  sortdate         :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  SortDateSt       :string(19)      default(""), not null
#

