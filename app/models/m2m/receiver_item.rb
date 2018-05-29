# == Schema Information
#
# Table name: rcitem
#
#  fitemno          :string(3)        default(""), not null
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  finvcost         :decimal(17, 5)   default(0.0), not null
#  fcategory        :string(8)        default(""), not null
#  fcstatus         :string(1)        default(""), not null
#  fiqtyinv         :decimal(15, 5)   default(0.0), not null
#  fjokey           :string(10)       default(""), not null
#  fsokey           :string(6)        default(""), not null
#  fsoitem          :string(3)        default(""), not null
#  fsorelsno        :string(3)        default(""), not null
#  fvqtyrecv        :decimal(15, 5)   default(0.0), not null
#  fqtyrecv         :decimal(15, 5)   default(0.0), not null
#  freceiver        :string(6)        default(""), not null
#  frelsno          :string(3)        default(""), not null
#  fvendno          :string(6)        default(""), not null
#  fbinno           :string(14)       default(""), not null
#  fexpdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  finspect         :string(1)        default(""), not null
#  finvqty          :decimal(15, 5)   default(0.0), not null
#  flocation        :string(14)       default(""), not null
#  flot             :string(20)       default(""), not null
#  fmeasure         :string(3)        default(""), not null
#  fpoitemno        :string(3)        default(""), not null
#  fretcredit       :string(1)        default(""), not null
#  ftype            :string(1)        default(""), not null
#  fumvori          :string(1)        default(""), not null
#  fqtyinsp         :decimal(15, 5)   default(0.0), not null
#  fauthorize       :string(20)       default(""), not null
#  fucost           :decimal(17, 5)   default(0.0), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  flexpreqd        :boolean          default(FALSE), not null
#  fctojoblot       :string(20)       default(""), not null
#  fdiscount        :decimal(5, 1)    default(0.0), not null
#  fueurocost       :decimal(17, 5)   default(0.0), not null
#  futxncost        :decimal(17, 5)   default(0.0), not null
#  fucostonly       :decimal(17, 5)   default(0.0), not null
#  futxncston       :decimal(17, 5)   default(0.0), not null
#  fueurcston       :decimal(17, 5)   default(0.0), not null
#  flconvovrd       :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fcomments        :text             default(""), not null
#  fdescript        :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  sfac             :string(20)       default(""), not null
#  FCORIGUM         :string(3)        default(""), not null
#  fcudrev          :string(3)        default(""), not null
#  FNORIGQTY        :decimal(18, 5)   default(0.0), not null
#  Iso              :string(10)       default(""), not null
#  Ship_Link        :integer          default(0), not null
#  ShsrceLink       :integer          default(0), not null
#  fCINSTRUCT       :string(2)        default(""), not null
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

  scope :by_time_received_desc, { :joins => :receiver, :order => 'rcmast.fdaterecv desc, rcitem.fitemno' }  
  scope :received_since, lambda { |date|
    { 
      :joins => :receiver, 
      :conditions => [ 'rcmast.fdaterecv >= ?', date ]
    }
  }
end

