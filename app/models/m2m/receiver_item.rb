# == Schema Information
#
# Table name: rcitem
#
#  fitemno          :char(3)          default("   "), not null
#  fpartno          :char(25)         default("                         "), not null
#  fpartrev         :char(3)          default("   "), not null
#  finvcost         :decimal(17, 5)   default(0.0), not null
#  fcategory        :char(8)          default("        "), not null
#  fcstatus         :char(1)          default(" "), not null
#  fiqtyinv         :decimal(15, 5)   default(0.0), not null
#  fjokey           :varchar(20)      default(""), not null
#  fsokey           :varchar(10)      default(""), not null
#  fsoitem          :char(3)          default("   "), not null
#  fsorelsno        :char(3)          default("   "), not null
#  fvqtyrecv        :decimal(15, 5)   default(0.0), not null
#  fqtyrecv         :decimal(15, 5)   default(0.0), not null
#  freceiver        :varchar(10)      default(""), not null
#  frelsno          :char(3)          default("   "), not null
#  fvendno          :char(6)          default("      "), not null
#  fbinno           :char(14)         default("              "), not null
#  fexpdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finspect         :char(1)          default(" "), not null
#  finvqty          :decimal(15, 5)   default(0.0), not null
#  flocation        :char(14)         default("              "), not null
#  flot             :varchar(50)      default(""), not null
#  fmeasure         :char(3)          default("   "), not null
#  fpoitemno        :char(3)          default("   "), not null
#  fretcredit       :char(1)          default(" "), not null
#  ftype            :char(1)          default(" "), not null
#  fumvori          :char(1)          default(" "), not null
#  fqtyinsp         :decimal(15, 5)   default(0.0), not null
#  fauthorize       :char(20)         default("                    "), not null
#  fucost           :decimal(17, 5)   default(0.0), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  flexpreqd        :boolean          default(FALSE), not null
#  fctojoblot       :varchar(50)      default(""), not null
#  fdiscount        :decimal(5, 1)    default(0.0), not null
#  fueurocost       :decimal(17, 5)   default(0.0), not null
#  futxncost        :decimal(17, 5)   default(0.0), not null
#  fucostonly       :decimal(17, 5)   default(0.0), not null
#  futxncston       :decimal(17, 5)   default(0.0), not null
#  fueurcston       :decimal(17, 5)   default(0.0), not null
#  flconvovrd       :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fcomments        :varchar_max(2147 default(""), not null
#  fdescript        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  sfac             :char(20)         default("                    "), not null
#  FCORIGUM         :char(3)          default("   "), not null
#  fcudrev          :char(3)          default("   "), not null
#  FNORIGQTY        :decimal(18, 5)   default(0.0), not null
#  Iso              :char(10)         default("          "), not null
#  Ship_Link        :integer          default(0), not null
#  ShsrceLink       :integer          default(0), not null
#  fCINSTRUCT       :char(2)          default("  "), not null
#  ffixcost         :decimal(17, 5)   default(0.0), not null
#  Ido              :varchar(10)      default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::ReceiverItem < M2m::Base
  self.table_name = 'rcitem'
  belongs_to :receiver, :class_name => 'M2m::Receiver', :foreign_key => :freceiver, :primary_key => :freceiver
  belongs_to_item :fpartno, :fpartrev
  
  alias_attribute :quantity, :fqtyrecv
  alias_attribute :receiver_number, :freceiver
  alias_attribute :purchase_order_item_number, :fpoitemno
  alias_attribute :release_number, :frelsno
  alias_attribute :purchase_order_item_number, :fpoitemno
  alias_attribute :item_number, :fitemno

  def purchase_order_item
    if self.receiver.purchase_order
      self.receiver.purchase_order.items.detect { |i| i.item_number == self.purchase_order_item_number }
    else
      nil
    end
  end 
  
  def po_vendor_part_number
    self.purchase_order_item.try(:vendor_part_number)
  end

  scope :by_time_received_desc, -> { joins(:receiver).order('rcmast.fdaterecv desc, rcitem.fitemno') }
  scope :received_since, -> (date) {
    joins(:receiver).
    where([ 'rcmast.fdaterecv >= ?', date ])
  }
  scope :date_received, -> (start_date, end_date) {
    start_date = start_date.is_a?(String) ? DateParser.parse(start_date) : start_date
    end_date = end_date.is_a?(String) ? DateParser.parse(end_date) : end_date
    joins(:receiver).where(['rcmast.fdaterecv >= ? and rcmast.fdaterecv < ?', start_date, end_date])
  }
  scope :invoiced, -> { where(fcategory: 'INV') }
  scope :closed, -> { where(fcstatus: 'C') }
end

