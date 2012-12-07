class M2m::SalesOrderRelease < M2m::Base

  # default_scope :order => 'sorels.fenumber'
  set_table_name 'sorels'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
  belongs_to_item :fpartno, :fpartrev
  attr_accessor :sales_order_item

  has_many :shipper_items, :class_name => 'M2m::ShipperItem', :finder_sql => 'select shitem.* from shitem where #{fsono} = SUBSTRING(shitem.fsokey,1,6) AND #{finumber} = SUBSTRING(shitem.fsokey,7,3) AND #{frelease} = SUBSTRING(shitem.fsokey,10,3)'

  scope :for_shipper_items, lambda { |shipper_items|
    if shipper_items.is_a?(M2m::ShipperItem)
      shipper_items = [shipper_items]
    end
    {
      :joins => 'inner join shitem on sorels.fsono = SUBSTRING(shitem.fsokey,1,6) AND sorels.finumber = SUBSTRING(shitem.fsokey,7,3) AND sorels.frelease = SUBSTRING(shitem.fsokey,10,3)',
      :conditions => ['shitem.identity_column in (?)', shipper_items.map(&:id)]
    }
  }
  scope :status_open,      :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.open.name} }
  scope :status_closed,    :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.closed.name} }
  scope :status_cancelled, :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.cancelled.name} }
  scope :status_not_cancelled, :joins => :sales_order, :conditions => ['somast.fstatus != ?', M2m::Status.cancelled.name]
  scope :by_due_date, :order => 'sorels.fduedate'
  scope :by_due_date_desc, :order => 'sorels.fduedate desc'
  scope :by_last_ship_date_desc, :order => 'sorels.flshipdate desc'
  scope :due_by, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'sorels.fduedate <= ?', date ]
    }
  }
  scope :due_after, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'sorels.fduedate >= ?', date ]
    }
  }
  scope :not_filled, :conditions => [ 'sorels.forderqty > (sorels.fshipbook + sorels.fshipbuy + sorels.fshipmake)' ]
  scope :some_filled, :conditions => [ '(sorels.fshipbook + sorels.fshipbuy + sorels.fshipmake) > 0' ]
  scope :filtered, :joins => 'left join soitem on soitem.fsono = sorels.fsono and soitem.fenumber = sorels.fenumber', :conditions => 'soitem.fmultiple = 0 OR sorels.frelease != \'000\''
  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision }
    }
  }
  scope :for_part_number, lambda { |item|
    fpartno = item.is_a?(M2m::Item) ? item.part_number : item.to_s
    {
      :conditions => { :fpartno => fpartno.strip }
    }
  }
  scope :part_number_starts_with, lambda { |part_number|
    {
      :conditions => [ 'sorels.fpartno like ?', part_number + '%' ]
    }
  }
  scope :with_status, lambda { |status|
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    {
      :conditions => { :somast => { :fstatus => status_name.upcase } }
    }
  }
  scope :customer, lambda { |customer|
    {
      :joins => :sales_order,
      :conditions => { :somast => { :fcustno => customer.customer_number } }
    }
  }
  scope :customers, lambda { |customer_numbers|
    customer_numbers = customer_numbers.map { |t| M2m::Customer.fcustno_for(t) }
    {
      :joins => :sales_order,
      :conditions => [ 'somast.fcustno in (?)', customer_numbers ]
    }
  }
  scope :for_sales_order, lambda { |sono|
    {
      :conditions => { :fsono => sono }
    }
  }
  scope :sales_order_numbers, lambda { |so_numbers|
    so_numbers = so_numbers.map { |n| M2m::SalesOrder.pad_sales_order_number(n) }
    {
      :conditions => [ 'sorels.fsono in (?)', so_numbers ]
    }
  }
  scope :with_number, lambda { |num|
    {
      :conditions => { :finumber => num }
    }
  }
  scope :shipped_after, lambda { |date|
    {
      :conditions => [ 'flshipdate >= ?', date ]
    }
  }
  scope :order_dates, lambda { |start_date, end_date|
    {
      :joins => :sales_order,
      :conditions => [ 'somast.forderdate >= ? and somast.forderdate < ?', start_date, end_date ]
    }
  }
  scope :ordered_since, lambda { |date|
    {
      :joins => :sales_order, 
      :conditions => ['somast.forderdate >= ?', date]
    }
  }
  scope :master, :conditions => { :fmasterrel => true }
  scope :master_or_single, joins('inner join soitem on soitem.fsono = sorels.fsono and soitem.fenumber = sorels.fenumber').where('(soitem.fmultiple = ? and sorels.fmasterrel = ?) or (soitem.fmultiple = ?)', true, true, false)

  # This does not work because belongs_to :item fails: "undefined local variable or method `fenumber'"
  # scope :not_masters, :joins => :item, :conditions => 'soitem.fmultiple = 0 OR sorels.frelease != \'000\''

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
  alias_attribute :due_date, :fduedate
  alias_attribute :order_quantity, :forderqty
  alias_attribute :internal_number, :finumber

  # select sorels.fduedate, sorels.flshipdate,
  # ((DATEDIFF(day, sorels.fduedate, sorels.flshipdate) -
  # DATEDIFF(wk, sorels.fduedate, sorels.flshipdate) * 2) -
  # case when DATEPART(dw, sorels.fduedate) = 1 then 1 else 0 end +
  # case when DATEPART(dw, sorels.flshipdate) = 1 then 1 else 0 end) as business_days_late,
  # DATEDIFF(day, sorels.fduedate, sorels.flshipdate) as days_late,
  # DATEDIFF(wk, sorels.fduedate, sorels.flshipdate) as weeks_late,
  # DATEPART(dw, sorels.fduedate) as due_day_of_week,
  # DATEPART(dw, sorels.flshipdate) as ship_day_of_week
  # from SOMAST left join sorels on sorels.fsono = somast.fsono
  # where
  # (DATEDIFF(day, somast.forderdate, sorels.fduedate) > 14)
  # AND (sorels.flshipdate > sorels.fduedate)
  # AND (((DATEDIFF(day, sorels.fduedate, sorels.flshipdate) -
  # DATEDIFF(wk, sorels.fduedate, sorels.flshipdate) * 2) -
  # case when DATEPART(dw, sorels.fduedate) = 1 then 1 else 0 end +
  # case when DATEPART(dw, sorels.flshipdate) = 1 then 1 else 0 end) > 2)

  # scope :shipped, :conditions => ['sorels.flshipdate != ?', Constants.null_time]
  scope :shipped_late, lambda {
    select_sql = <<-SQL
    sorels.*, ((DATEDIFF(day, sorels.fduedate, sorels.flshipdate) -
    DATEDIFF(wk, sorels.fduedate, sorels.flshipdate) * 2) - 
    case when DATEPART(dw, sorels.fduedate) = 1 then 1 else 0 end +
    case when DATEPART(dw, sorels.flshipdate) = 1 then 1 else 0 end) as business_days_late
    SQL
    conditions_sql = <<-SQL
    (DATEDIFF(day, somast.forderdate, sorels.fduedate) > ?)
    AND (sorels.flshipdate > sorels.fduedate)
    AND (((DATEDIFF(day, sorels.fduedate, sorels.flshipdate) -
           DATEDIFF(wk, sorels.fduedate, sorels.flshipdate) * 2) -
          case when DATEPART(dw, sorels.fduedate) = 1 then 1 else 0 end +
          case when DATEPART(dw, sorels.flshipdate) = 1 then 1 else 0 end) > ?)
    SQL
    {
      :joins => :sales_order,
      :select => select_sql,
      :conditions => [ conditions_sql, AppConfig.otd_lead_time, AppConfig.otd_grace_period_days ]
    }
  }
  scope :due, lambda { |start_date, end_date|
    {
      :conditions => ['sorels.fduedate >= ? and sorels.fduedate < ?', start_date, end_date]
    }
  }
  scope :ids, lambda { |ids|
    {
      :conditions => ['sorels.identity_column in (?)', ids]
    }
  }

  def days_late(date=nil)
    return 0 unless self.due_date.present?
    date ||= self.last_ship_date || Time.current
    (date.to_time - self.due_date).to_i / 86400
  end

  def last_ship_date
    M2m::Constants.sanitize_date(self.flshipdate)
  end

  def due_date
    M2m::Constants.sanitize_date(self.fduedate)
  end

  # def due_date_month
  #   @due_date_month ||= Date.new(self.due_date.year, self.due_date.month, 1)
  # end
  #
  def quantity_shipped
    (self.fshipbook || 0) + (self.fshipbuy || 0) + (self.fshipmake || 0)
  end

  def backorder_quantity
    quantity - quantity_shipped
  end
  
  def backlog_price
    self.backorder_quantity * self.unit_price
  end  

  # Optimization to avoid the inefficiency of the belongs_to above.
  def attach_items_from_sales_order(sales_order)
    self.sales_order_item = sales_order.items.detect { |i| i.fenumber == self.fenumber }
    self.item = self.sales_order_item.try(:item)
  end

  def self.attach_to_sales_orders(sales_orders)
    sales_orders.each do |so|
      so.releases.each do |r|
        r.sales_order = so
      end
    end
  end

  def status
    if self.sales_order.status.try(:closed?)
      if quantity_shipped == 0
        M2m::Status.cancelled
      elsif backorder_quantity <= 0
        M2m::Status.shipped
      else
        M2m::Status.closed_short
      end
    elsif self.sales_order.status.try(:open?)
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
    (backorder_quantity > 0) && item.item && (item.item.quantity_on_hand > 0) && (item.item.quantity_on_hand < backorder_quantity)
  end

  def master?
    self.fmasterrel
  end

end



# == Schema Information
#
# Table name: sorels
#
#  fenumber         :string(3)       default(""), not null
#  finumber         :string(3)       default(""), not null
#  fpartno          :string(25)      default(""), not null
#  fpartrev         :string(3)       default(""), not null
#  frelease         :string(3)       default(""), not null
#  fshptoaddr       :string(4)       default(""), not null
#  fsono            :string(6)       default(""), not null
#  favailship       :boolean         default(FALSE), not null
#  fbook            :decimal(15, 5)  default(0.0), not null
#  fbqty            :decimal(15, 5)  default(0.0), not null
#  fdiscount        :decimal(17, 5)  default(0.0), not null
#  fduedate         :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  finvamount       :decimal(17, 5)  default(0.0), not null
#  finvqty          :decimal(15, 5)  default(0.0), not null
#  fjob             :boolean         default(FALSE), not null
#  fjoqty           :decimal(15, 5)  default(0.0), not null
#  flabcost         :decimal(17, 5)  default(0.0), not null
#  flngth           :decimal(15, 5)  default(0.0), not null
#  flshipdate       :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmasterrel       :boolean         default(FALSE), not null
#  fmatlcost        :decimal(17, 5)  default(0.0), not null
#  fmaxqty          :decimal(15, 5)  default(0.0), not null
#  fmqty            :decimal(15, 5)  default(0.0), not null
#  fmsi             :decimal(15, 5)  default(0.0), not null
#  fnetprice        :decimal(17, 5)  default(0.0), not null
#  fninvship        :decimal(15, 5)  default(0.0), not null
#  fnpurvar         :decimal(, )     default(0.0), not null
#  forderqty        :decimal(15, 5)  default(0.0), not null
#  fothrcost        :decimal(17, 5)  default(0.0), not null
#  fovhdcost        :decimal(17, 5)  default(0.0), not null
#  fpoqty           :decimal(15, 5)  default(0.0), not null
#  fpostatus        :string(6)       default(""), not null
#  fquant           :decimal(15, 5)  default(0.0), not null
#  fsetupcost       :decimal(17, 5)  default(0.0), not null
#  fshipbook        :decimal(15, 5)  default(0.0), not null
#  fshipbuy         :decimal(15, 5)  default(0.0), not null
#  fshipmake        :decimal(15, 5)  default(0.0), not null
#  fshpbefdue       :boolean         default(FALSE), not null
#  fsplitshp        :boolean         default(FALSE), not null
#  fstatus          :string(10)      default(""), not null
#  fstkqty          :decimal(15, 5)  default(0.0), not null
#  fsubcost         :decimal(17, 5)  default(0.0), not null
#  ftoolcost        :decimal(17, 5)  default(0.0), not null
#  ftoshpbook       :decimal(15, 5)  default(0.0), not null
#  ftoshpbuy        :decimal(15, 5)  default(0.0), not null
#  ftoshpmake       :decimal(15, 5)  default(0.0), not null
#  funetprice       :decimal(17, 5)  default(0.0), not null
#  fvendno          :string(6)       default(""), not null
#  fwidth           :decimal(15, 5)  default(0.0), not null
#  fnretpoqty       :decimal(17, 5)  default(0.0), not null
#  fnettxnprice     :decimal(17, 5)  default(0.0), not null
#  funettxnpric     :decimal(17, 5)  default(0.0), not null
#  fneteuropr       :decimal(17, 5)  default(0.0), not null
#  funeteuropr      :decimal(17, 5)  default(0.0), not null
#  fdiscpct         :decimal(17, 5)  default(0.0), not null
#  fljrdif          :boolean         default(FALSE), not null
#  flistaxabl       :boolean         default(FALSE), not null
#  flatp            :boolean         default(FALSE), not null
#  fcbin            :string(14)      default(""), not null
#  fcloc            :string(14)      default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdelivery        :text            default(""), not null
#  fcpbtype         :string(1)       default(""), not null
#  fcudrev          :string(3)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#  fpriority        :integer(4)      default(4), not null
#  SchedDate        :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flInvcPoss       :boolean         default(FALSE), not null
#  fmatlpadj        :decimal(16, 5)  default(0.0), not null
#  ftoolpadj        :decimal(16, 5)  default(0.0), not null
#  flabpadj         :decimal(16, 5)  default(0.0), not null
#  fovhdpadj        :decimal(16, 5)  default(0.0), not null
#  fsubpadj         :decimal(16, 5)  default(0.0), not null
#  fothrpadj        :decimal(16, 5)  default(0.0), not null
#  fsetuppadj       :decimal(16, 5)  default(0.0), not null
#  fnISOQty         :decimal(15, 5)  default(0.0), not null
#

