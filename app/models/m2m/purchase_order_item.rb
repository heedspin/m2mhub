# == Schema Information
#
# Table name: poitem
#
#  fpono            :string(6)        default(""), not null
#  fpartno          :string(25)       default(""), not null
#  frev             :string(3)        default(""), not null
#  fmeasure         :string(3)        default(""), not null
#  fitemno          :string(3)        default(""), not null
#  frelsno          :string(3)        default(""), not null
#  fcategory        :string(8)        default(""), not null
#  fsokey           :string(6)        default(""), not null
#  fsoitm           :string(3)        default(""), not null
#  fsorls           :string(3)        default(""), not null
#  fjokey           :string(10)       default(""), not null
#  fjoitm           :string(6)        default(""), not null
#  fjoopno          :integer          default(0), not null
#  flstcost         :decimal(17, 5)   default(0.0), not null
#  fstdcost         :decimal(17, 5)   default(0.0), not null
#  fleadtime        :decimal(5, 1)    default(0.0), not null
#  forgpdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flstpdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fmultirls        :string(1)        default(""), not null
#  fnextrels        :integer          default(0), not null
#  fnqtydm          :decimal(15, 5)   default(0.0), not null
#  freqdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fretqty          :decimal(15, 5)   default(0.0), not null
#  fordqty          :decimal(15, 5)   default(0.0), not null
#  fqtyutol         :decimal(6, 2)    default(0.0), not null
#  fqtyltol         :decimal(6, 2)    default(0.0), not null
#  fbkordqty        :decimal(15, 5)   default(0.0), not null
#  flstsdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frcpdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frcpqty          :decimal(15, 5)   default(0.0), not null
#  fshpqty          :decimal(15, 5)   default(0.0), not null
#  finvqty          :decimal(15, 5)   default(0.0), not null
#  fdiscount        :decimal(5, 1)    default(0.0), not null
#  frework          :string(1)        default(""), not null
#  fstandard        :boolean          default(FALSE), not null
#  ftax             :string(1)        default(""), not null
#  fsalestax        :decimal(7, 3)    default(0.0), not null
#  finspect         :string(1)        default(""), not null
#  flcost           :decimal(17, 5)   default(0.0), not null
#  fucost           :decimal(17, 5)   default(0.0), not null
#  fprintmemo       :string(1)        default(""), not null
#  fvlstcost        :decimal(17, 5)   default(0.0), not null
#  fvleadtime       :decimal(5, 1)    default(0.0), not null
#  fvmeasure        :string(5)        default(""), not null
#  fvpartno         :string(25)       default(""), not null
#  fvptdes          :string(35)       default(""), not null
#  fvordqty         :decimal(15, 5)   default(0.0), not null
#  fvconvfact       :decimal(13, 9)   default(0.0), not null
#  fvucost          :decimal(17, 5)   default(0.0), not null
#  fqtyshipr        :decimal(15, 5)   default(0.0), not null
#  fdateship        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fparentpo        :string(6)        default(""), not null
#  frmano           :string(25)       default(""), not null
#  fdebitmemo       :string(1)        default(""), not null
#  finspcode        :string(4)        default(""), not null
#  freceiver        :string(6)        default(""), not null
#  fnorgucost       :decimal(17, 5)   default(0.0), not null
#  fcorgcateg       :string(19)       default(""), not null
#  fparentitm       :string(3)        default(""), not null
#  fparentrls       :string(3)        default(""), not null
#  frecvitm         :string(3)        default(""), not null
#  fnorgeurcost     :decimal(17, 5)   default(0.0), not null
#  fnorgtxncost     :decimal(17, 5)   default(0.0), not null
#  fueurocost       :decimal(17, 5)   default(0.0), not null
#  futxncost        :decimal(17, 5)   default(0.0), not null
#  fvueurocost      :decimal(17, 5)   default(0.0), not null
#  fvutxncost       :decimal(17, 5)   default(0.0), not null
#  fljrdif          :boolean          default(FALSE), not null
#  fucostonly       :decimal(17, 5)   default(0.0), not null
#  futxncston       :decimal(17, 5)   default(0.0), not null
#  fueurcston       :decimal(17, 5)   default(0.0), not null
#  fcbin            :string(14)       default(""), not null
#  fcloc            :string(14)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fcomments        :text             default(""), not null
#  fdescript        :text             default(""), not null
#  Fac              :string(20)       default(""), not null
#  fcudrev          :string(3)        default(""), not null
#  fndbrmod         :integer          default(0), not null
#  blanketPO        :boolean          default(FALSE), not null
#  PlaceDate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  DockTime         :integer          default(0), not null
#  PurchBuf         :integer          default(0), not null
#  Final            :boolean          default(FALSE), not null
#  AvailDate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  SchedDate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#

class M2m::PurchaseOrderItem < M2m::Base
  self.table_name = 'poitem'

  belongs_to :purchase_order, :class_name => 'M2m::PurchaseOrder', :foreign_key => :fpono
  belongs_to_item :fpartno, :frev
  has_many :inspection_tasks, :class_name => 'Quality::InspectionTask', :foreign_key => :purchase_order_item_id

  alias_attribute :purchase_order_number, :fpono
  alias_attribute :ship_date, :fdateship
  alias_attribute :quantity, :fordqty
  alias_attribute :quantity_received, :frcpqty
  alias_attribute :item_number, :fitemno
  alias_attribute :requisition_date, :freqdate
  alias_attribute :release, :frelsno
  alias_date_attribute :date_received, :frcpdate
  alias_date_attribute :last_promise_date, :flstpdate
  alias_date_attribute :original_promise_date, :forgpdate
  # alias_date_attribute :request_date, :freqdate
  alias_attribute :unit_cost, :fucost
  alias_attribute :inspection_required, :finspect
  def inspection_required?
    self.inspection_required == 'Y'
  end

  def safe_promise_date
    self.last_promise_date || self.original_promise_date || Time.current.advance(:years => 1)
  end

  scope :status_open,      -> { joins(:purchase_order).where(:pomast => {:fstatus => M2m::PurchaseOrderStatus.open.name}) }
  scope :status_closed,    -> { joins(:purchase_order).where(:pomast => {:fstatus => M2m::PurchaseOrderStatus.closed.name}) }
  scope :status_cancelled, -> { joins(:purchase_order).where(:pomast => {:fstatus => M2m::PurchaseOrderStatus.cancelled.name}) }
  scope :for_item, -> (item) {
    where :fpartno => item.part_number, :frev => item.revision
  }
  scope :for_itemno, -> (itemno) {
    where :fitemno => itemno
  }
  scope :with_status, -> (status) {
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    where :pomast => { :fstatus => status_name.upcase }
  }
  def self.not_cancelled
    where ['pomast.fstatus != ?', M2m::PurchaseOrderStatus.cancelled.name]
  end
  scope :rev_order, -> { order('poitem.fpono desc, poitem.fitemno') }
  scope :filtered, -> { where(['poitem.fmultirls != ? or poitem.frelsno != ?', 'Y', 0]) }
  scope :vendor, -> (vendor) {
    vendor_number = vendor.is_a?(M2m::Vendor) ? vendor.vendor_number : vendor
    joins(:purchase_order).
    where(:pomast => { :fvendno => vendor_number })
  }
  scope :last_promised_after, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where [ 'poitem.flstpdate >= ?', date ]
  }
  scope :by_last_promised, -> { order(:flstpdate) }
  scope :by_date_received_desc, -> { order('poitem.frcpdate').reverse_order }
  scope :by_po_date_desc, -> { order('pomast.forddate').reverse_order }
  scope :inspection_required, -> (ch) {
    if ch.is_a?(TrueClass)
      ch = 'Y'
    elsif ch.is_a?(FalseClass)
      ch = 'N'
    end
    where :finspect => ch
  }

  def master_release?
    (self.fmultirls.strip == 'Y') && (self.frelsno.to_i == 0)
  end

  # The master release carries all undelivered quantities from previous releases.
  def master_remainder_quantity
    return 0 unless self.master_release?
    self.purchase_order.items.filtered.for_itemno(self.fitemno).all.sum do |i|
      i.quantity_for_master_remainder
    end
  end

  def quantity_for_master_remainder
    consider_past_date = self.date_received || self.last_promise_date
    if (self.quantity_received > 0) || (self.last_promise_date < Date.current)
      self.backorder_quantity
    else
      0
    end
  end

  def backorder_quantity
    quantity - quantity_received
  end

  def status
    if self.purchase_order.status.closed?
      if quantity_received == 0
        M2m::Status.cancelled
      elsif backorder_quantity <= 0
        M2m::Status.received
      else
        M2m::Status.closed_short
      end
    elsif self.purchase_order.status.open?
      if quantity_received == 0
        M2m::Status.open
      elsif backorder_quantity == 0
        M2m::Status.receiving
      else
        M2m::Status.partial
      end
    else
      self.purchase_order.status
    end
  end

  def closed?
    self.purchase_order.status.closed?
  end

  def vendor_part_number
    self.fvpartno.strip
  end
end

