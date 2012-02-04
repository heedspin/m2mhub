class M2m::Receiver < M2m::Base
  set_table_name 'rcmast'
  set_primary_key 'freceiver'
  
  has_many :receiver_items, :class_name => 'M2m::ReceiverItem', :foreign_key => :freceiver, :primary_key => :freceiver
  belongs_to :purchase_order, :class_name => 'M2m::PurchaseOrder', :foreign_key => :fpono, :primary_key => :fpono
  
  alias_attribute :time_received, :fdaterecv  
  alias_attribute :purchase_order_number, :fpono
  alias_attribute :received_by, :faccptby
  
  def date_received
    self.time_received.to_date
  end

  scope :with_date_received, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'rcmast.fdaterecv >= ? and rcmast.fdaterecv < ?', date.to_s(:database), date.advance(:days => 1).to_s(:database) ],
    }
  }
  
  scope :for_next_day, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'rcmast.fdaterecv >= ?', date.advance(:days => 1).to_s(:database) ],
      :order => :fdaterecv
    }
  }
  
  scope :for_previous_day, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'rcmast.fdaterecv < ?', date.to_s(:database) ],
      :order => 'rcmast.fdaterecv desc'
    }
  }
  
  scope :by_id_desc, :order => 'rcmast.freceiver desc'
  
  def status
    # fcstatus are 'C' and 'I' but always show up received.
    self.fcstatus ? 'Received' : 'Not Received'
  end
  
end


# == Schema Information
#
# Table name: rcmast
#
#  fclandcost       :string(1)       default(""), not null
#  frmano           :string(25)      default(""), not null
#  fporev           :string(2)       default(""), not null
#  fcstatus         :string(1)       default(""), not null
#  fdaterecv        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fpono            :string(6)       default(""), not null
#  freceiver        :string(6)       default(""), not null, primary key
#  fvendno          :string(6)       default(""), not null
#  faccptby         :string(3)       default(""), not null
#  fbilllad         :string(18)      default(""), not null
#  fcompany         :string(35)      default(""), not null
#  ffrtcarr         :string(20)      default(""), not null
#  fpacklist        :string(15)      default(""), not null
#  fretship         :string(1)       default(""), not null
#  fshipwgt         :decimal(11, 2)  default(0.0), not null
#  ftype            :string(1)       default(""), not null
#  start            :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fprinted         :boolean         default(FALSE), not null
#  flothrupd        :boolean         default(FALSE), not null
#  fccurid          :string(3)       default(""), not null
#  fcfactor         :decimal(17, 5)  default(0.0), not null
#  fdcurdate        :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  fdeurodate       :datetime        default(Mon Jan 01 00:00:00 -0500 1900), not null
#  feurofctr        :decimal(17, 5)  default(0.0), not null
#  flpremcv         :boolean         default(FALSE), not null
#  identity_column  :integer(4)      not null
#  timestamp_column :binary
#  docstatus        :string(10)      default("STARTED")
#  frmacreator      :string(25)      default(""), not null
#

