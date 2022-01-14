# == Schema Information
#
# Table name: rcmast
#
#  fclandcost       :char(1)          default(" "), not null
#  frmano           :char(25)         default("                         "), not null
#  fporev           :char(2)          default("  "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fdaterecv        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpono            :varchar(10)      default(""), not null
#  freceiver        :varchar(10)      default(""), not null, primary key
#  fvendno          :char(6)          default("      "), not null
#  faccptby         :char(3)          default("   "), not null
#  fbilllad         :char(18)         default("                  "), not null
#  fcompany         :varchar(35)      default(""), not null
#  ffrtcarr         :char(20)         default("                    "), not null
#  fpacklist        :char(15)         default("               "), not null
#  fretship         :char(1)          default(" "), not null
#  fshipwgt         :decimal(11, 2)   default(0.0), not null
#  ftype            :char(1)          default(" "), not null
#  start            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fprinted         :boolean          default(FALSE), not null
#  flothrupd        :boolean          default(FALSE), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  fdcurdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  flpremcv         :boolean          default(FALSE), not null
#  identity_column  :integer          not null
#  timestamp_column :ss_timestamp
#  docstatus        :char(10)         default("STARTED   ")
#  frmacreator      :varchar(25)      default(""), not null
#  usefirstlot      :boolean          default(FALSE), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Receiver < M2m::Base
  self.table_name = 'rcmast'
  self.primary_key = 'freceiver'
  
  has_many :items, :class_name => 'M2m::ReceiverItem', :foreign_key => :freceiver, :primary_key => :freceiver
  belongs_to :purchase_order, :class_name => 'M2m::PurchaseOrder', :foreign_key => :fpono, :primary_key => :fpono
  belongs_to :vendor, :class_name => 'M2m::Vendor', :foreign_key => 'fvendno', :primary_key => 'fvendno'
  
  alias_attribute :time_received, :fdaterecv  
  alias_attribute :purchase_order_number, :fpono
  alias_attribute :received_by, :faccptby
  alias_attribute :receiver_number, :freceiver
  def rma_number
    self.frmano.strip
  end
  
  def date_received
    self.time_received.to_date
  end

  scope :with_date_received, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where(['rcmast.fdaterecv >= ? and rcmast.fdaterecv < ?', date, date.advance(:days => 1)])
  }
  scope :date_received, -> (start_date, end_date) {
    start_date = start_date.is_a?(String) ? DateParser.parse(start_date) : start_date
    end_date = end_date.is_a?(String) ? DateParser.parse(end_date) : end_date
    where(['rcmast.fdaterecv >= ? and rcmast.fdaterecv < ?', start_date, end_date])
  }
  scope :for_next_day, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where(['rcmast.fdaterecv >= ?', date.advance(:days => 1)]).
    order(:fdaterecv)
  }
  scope :for_previous_day, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where([ 'rcmast.fdaterecv < ?', date.to_s(:database) ]).
    order('rcmast.fdaterecv desc')
  }
  scope :by_id_desc, -> { order('rcmast.freceiver desc') }
  scope :rma_number, -> (rma_number) {
    if rma_number.is_a?(Enumerable)
      where ['rcmast.frmano in (?)', rma_number.map { |n| M2m::Rma.pad_rma_number(n) } ]
    else
      where :frmano => M2m::Rma.pad_rma_number(rma_number)
    end
  }
  scope :purchase_order_number, -> (pono) {
    if pono.is_a?(Enumerable)
      where ['rcmast.fpono in (?)', pono.map { |n| M2m::PurchaseOrder.pad_purchase_order_number(n) } ]
    else
      where :fpono => M2m::PurchaseOrder.pad_purchase_order_number(pono)
    end
  }
  scope :by_time_received_desc, -> { order('rcmast.fdaterecv desc') }
  scope :has_purchase_order, -> { where('rcmast.fpono <> \'\'')}
    
  def status
    # fcstatus are 'C' and 'I' but always show up received.
    self.fcstatus ? 'Received' : 'Not Received'
  end
  
end

