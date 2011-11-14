class M2m::SalesOrderRelease < M2m::Base
  
  default_scope :order => 'sorels.fenumber'
  set_table_name 'sorels'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
  belongs_to :item, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fsono, :primary_key => :fsono, :conditions => 'soitem.fenumber = \'#{fenumber}\''

  has_many :shipper_items, :class_name => 'M2m::ShipperItem', :finder_sql => 'select shitem.* from shitem where #{fsono} = SUBSTRING(shitem.fsokey,1,6) AND #{finumber} = SUBSTRING(shitem.fsokey,7,3) AND #{frelease} = SUBSTRING(shitem.fsokey,10,3)'

  named_scope :for_shipper_items, lambda { |shipper_items|
    if shipper_items.is_a?(M2m::ShipperItem)
      shipper_items = [shipper_items]
    end
    {
      :joins => 'inner join shitem on sorels.fsono = SUBSTRING(shitem.fsokey,1,6) AND sorels.finumber = SUBSTRING(shitem.fsokey,7,3) AND sorels.frelease = SUBSTRING(shitem.fsokey,10,3)',
      :conditions => ['shitem.identity_column in (?)', shipper_items.map(&:id)]
    }
  }

  named_scope :open,      :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.open.name} }
  named_scope :closed,    :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.closed.name} }
  named_scope :cancelled, :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.cancelled.name} }

  named_scope :by_due_date, :order => :fduedate
  named_scope :by_due_date_desc, :order => 'sorels.fduedate desc'

  named_scope :due_by, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'sorels.fduedate <= ?', date.to_s(:database) ]
    }
  }

  named_scope :not_filled, :conditions => [ 'sorels.forderqty > (sorels.fshipbook + sorels.fshipbuy + sorels.fshipmake)' ]

  named_scope :filtered, :joins => 'left join soitem on soitem.fsono = sorels.fsono and soitem.fenumber = sorels.fenumber', :conditions => 'soitem.fmultiple = 0 OR sorels.frelease != \'000\''

  named_scope :for_item, lambda { |item|
    fpartno = item.is_a?(M2m::Item) ? item.fpartno : item.to_s
    {
      :conditions => { :fpartno => fpartno.strip } 
    }
  }
  
  named_scope :with_status, lambda { |status|
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    {
      :conditions => { :somast => { :fstatus => status_name.upcase } }
    }
  }

  # This does not work because belongs_to :item fails: "undefined local variable or method `fenumber'"
  # named_scope :not_masters, :joins => :item, :conditions => 'soitem.fmultiple = 0 OR sorels.frelease != \'000\''

  def quantity
    self.forderqty > 0 ? self.forderqty : self.item.quantity
  end

  def release_price
    self.quantity * self.unit_price
  end

  alias_attribute :unit_price, :funetprice
  alias_attribute :total_price, :fnetprice
  alias_attribute :sales_order_number, :fsono
  alias_attribute :sales_order_release_id, :finumber
  alias_attribute :sales_order_release_number, :frelease
  alias_attribute :revision, :fpartrev
  
  def last_ship_date
    self.flshipdate == M2m::Constants.null_date ? nil : self.flshipdate
  end

  def due_date
    self.fduedate == M2m::Constants.null_date ? nil : self.fduedate
  end

  def quantity_shipped
    (self.fshipbook || 0) + (self.fshipbuy || 0) + (self.fshipmake || 0)
  end

  def backorder_quantity
    quantity - quantity_shipped
  end

  def part_number
    self.fpartno.strip
  end

  def part_rev
    self.fpartrev.strip
  end

  # Optimization to avoid the inefficiency of the belongs_to above.
  def attach_items_from_sales_order(sales_order)
    self.item = sales_order.items.detect { |i| i.fenumber == self.fenumber }
  end

  def status
    if self.sales_order.status.closed?
      if quantity_shipped == 0
        M2m::Status.cancelled
      elsif backorder_quantity <= 0
        M2m::Status.shipped
      else
        M2m::Status.closed_short
      end
    elsif self.sales_order.status.open?
      if quantity_shipped == 0
        M2m::Status.open
      elsif backorder_quantity <= 0
        M2m::Status.shipped
      else
        M2m::Status.partial
      end
    else
      self.sales_order.status
    end
  end

  def closed?
    self.sales_order.try(:closed?)
  end

  def can_be_fully_shipped?
    (backorder_quantity > 0) && item.item && (item.item.quantity_on_hand >= backorder_quantity)
  end

  def can_be_partially_shipped?
    (backorder_quantity > 0) && (item.item.quantity_on_hand > 0) && item.item && (item.item.quantity_on_hand < backorder_quantity)
  end
end


# == Schema Information
#
# Table name: sorels
#
#  fenumber         :string(3)       not null
#  finumber         :string(3)       not null
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  frelease         :string(3)       not null
#  fshptoaddr       :string(4)       not null
#  fsono            :string(6)       not null
#  favailship       :boolean         not null
#  fbook            :decimal(15, 5)  not null
#  fbqty            :decimal(15, 5)  not null
#  fdiscount        :decimal(17, 5)  not null
#  fduedate         :datetime        not null
#  finvamount       :decimal(17, 5)  not null
#  finvqty          :decimal(15, 5)  not null
#  fjob             :boolean         not null
#  fjoqty           :decimal(15, 5)  not null
#  flabcost         :decimal(17, 5)  not null
#  flngth           :decimal(15, 5)  not null
#  flshipdate       :datetime        not null
#  fmasterrel       :boolean         not null
#  fmatlcost        :decimal(17, 5)  not null
#  fmaxqty          :decimal(15, 5)  not null
#  fmqty            :decimal(15, 5)  not null
#  fmsi             :decimal(15, 5)  not null
#  fnetprice        :decimal(17, 5)  not null
#  fninvship        :decimal(15, 5)  not null
#  fnpurvar         :decimal(, )     not null
#  forderqty        :decimal(15, 5)  not null
#  fothrcost        :decimal(17, 5)  not null
#  fovhdcost        :decimal(17, 5)  not null
#  fpoqty           :decimal(15, 5)  not null
#  fpostatus        :string(6)       not null
#  fquant           :decimal(15, 5)  not null
#  fsetupcost       :decimal(17, 5)  not null
#  fshipbook        :decimal(15, 5)  not null
#  fshipbuy         :decimal(15, 5)  not null
#  fshipmake        :decimal(15, 5)  not null
#  fshpbefdue       :boolean         not null
#  fsplitshp        :boolean         not null
#  fstatus          :string(10)      not null
#  fstkqty          :decimal(15, 5)  not null
#  fsubcost         :decimal(17, 5)  not null
#  ftoolcost        :decimal(17, 5)  not null
#  ftoshpbook       :decimal(15, 5)  not null
#  ftoshpbuy        :decimal(15, 5)  not null
#  ftoshpmake       :decimal(15, 5)  not null
#  funetprice       :decimal(17, 5)  not null
#  fvendno          :string(6)       not null
#  fwidth           :decimal(15, 5)  not null
#  fnretpoqty       :decimal(17, 5)  not null
#  fnettxnprice     :decimal(17, 5)  not null
#  funettxnpric     :decimal(17, 5)  not null
#  fneteuropr       :decimal(17, 5)  not null
#  funeteuropr      :decimal(17, 5)  not null
#  fdiscpct         :decimal(17, 5)  not null
#  fljrdif          :boolean         not null
#  flistaxabl       :boolean         not null
#  flatp            :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdelivery        :text            default(" "), not null
#  fcpbtype         :string(1)       default(""), not null
#  fcbin            :string(14)      default(" "), not null
#  fcloc            :string(14)      default(" "), not null
#  fcudrev          :string(3)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#  fpriority        :integer(4)      default(4), not null
#  SchedDate        :datetime        not null
#

