class M2m::PurchaseOrderItem < M2m::Base
  set_table_name 'poitem'

  belongs_to :purchase_order, :class_name => 'M2m::PurchaseOrder', :foreign_key => :fpono
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => :fpartno, :primary_key => :fpartno
  # belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fpartno, :fpartrev]
  
  alias_attribute :purchase_order_number, :fpono
  alias_attribute :ship_date, :fdateship
  alias_attribute :quantity, :fordqty
  alias_attribute :quantity_received, :frcpqty
  alias_attribute :item_number, :fitemno
  alias_attribute :requisition_date, :freqdate
  alias_attribute :release, :frelsno
  
  def part_number
    self.fpartno.strip
  end
  
  named_scope :open,      :joins => :purchase_order, :conditions => { :pomast => {:fstatus => M2m::Status.open.name} }
  named_scope :closed,    :joins => :purchase_order, :conditions => { :pomast => {:fstatus => M2m::Status.closed.name} }
  named_scope :cancelled, :joins => :purchase_order, :conditions => { :pomast => {:fstatus => M2m::Status.cancelled.name} }
  
  named_scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number }
    }
  }
  
  named_scope :for_itemno, lambda { |itemno|
    {
      :conditions => { :fitemno => itemno }
    }
  }
    
  named_scope :with_status, lambda { |status|
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    {
      :conditions => { :pomast => { :fstatus => status_name.upcase } }
    }
  }
  
  named_scope :reverse_order, :order => 'poitem.fpono desc, poitem.fitemno'

  named_scope :filtered, :conditions => ['poitem.fmultirls != ? or poitem.frelsno != ?', 'Y', 0]

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

  def date_received
    self.frcpdate == M2m::Constants.null_date ? nil : self.frcpdate
  end
  
  def last_promise_date
    self.flstpdate == M2m::Constants.null_date ? nil : self.flstpdate
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
end
# == Schema Information
#
# Table name: poitem
#
#  fpono            :string(6)       not null
#  fpartno          :string(25)      not null
#  frev             :string(3)       not null
#  fmeasure         :string(3)       not null
#  fitemno          :string(3)       not null
#  frelsno          :string(3)       not null
#  fcategory        :string(8)       not null
#  fsokey           :string(6)       not null
#  fsoitm           :string(3)       not null
#  fsorls           :string(3)       not null
#  fjokey           :string(10)      not null
#  fjoitm           :string(6)       not null
#  fjoopno          :integer         not null
#  flstcost         :decimal(17, 5)  not null
#  fstdcost         :decimal(17, 5)  not null
#  fleadtime        :decimal(5, 1)   not null
#  forgpdate        :datetime        not null
#  flstpdate        :datetime        not null
#  fmultirls        :string(1)       not null
#  fnextrels        :integer         not null
#  fnqtydm          :decimal(15, 5)  not null
#  freqdate         :datetime        not null
#  fretqty          :decimal(15, 5)  not null
#  fordqty          :decimal(15, 5)  not null
#  fqtyutol         :decimal(6, 2)   not null
#  fqtyltol         :decimal(6, 2)   not null
#  fbkordqty        :decimal(15, 5)  not null
#  flstsdate        :datetime        not null
#  frcpdate         :datetime        not null
#  frcpqty          :decimal(15, 5)  not null
#  fshpqty          :decimal(15, 5)  not null
#  finvqty          :decimal(15, 5)  not null
#  fdiscount        :decimal(5, 1)   not null
#  frework          :string(1)       not null
#  fstandard        :boolean         not null
#  ftax             :string(1)       not null
#  fsalestax        :decimal(7, 3)   not null
#  finspect         :string(1)       not null
#  flcost           :decimal(17, 5)  not null
#  fucost           :decimal(17, 5)  not null
#  fprintmemo       :string(1)       not null
#  fvlstcost        :decimal(17, 5)  not null
#  fvleadtime       :decimal(5, 1)   not null
#  fvmeasure        :string(5)       not null
#  fvpartno         :string(25)      not null
#  fvptdes          :string(35)      default(" "), not null
#  fvordqty         :decimal(15, 5)  not null
#  fvconvfact       :decimal(13, 9)  not null
#  fvucost          :decimal(17, 5)  not null
#  fqtyshipr        :decimal(15, 5)  not null
#  fdateship        :datetime        not null
#  fparentpo        :string(6)       not null
#  frmano           :string(25)      not null
#  fdebitmemo       :string(1)       not null
#  finspcode        :string(4)       not null
#  freceiver        :string(6)       not null
#  fnorgucost       :decimal(17, 5)  not null
#  fcorgcateg       :string(19)      not null
#  fparentitm       :string(3)       not null
#  fparentrls       :string(3)       not null
#  frecvitm         :string(3)       not null
#  fnorgeurcost     :decimal(17, 5)  not null
#  fnorgtxncost     :decimal(17, 5)  not null
#  fueurocost       :decimal(17, 5)  not null
#  futxncost        :decimal(17, 5)  not null
#  fvueurocost      :decimal(17, 5)  not null
#  fvutxncost       :decimal(17, 5)  not null
#  fljrdif          :boolean         not null
#  fucostonly       :decimal(17, 5)  not null
#  futxncston       :decimal(17, 5)  not null
#  fueurcston       :decimal(17, 5)  not null
#  fcbin            :string(14)      not null
#  fcloc            :string(14)      not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fcomments        :text            default(" "), not null
#  fdescript        :text            default(" "), not null
#  Fac              :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#

