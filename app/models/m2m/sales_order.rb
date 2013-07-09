# == Schema Information
#
# Table name: somast
#
#  fsono            :string(6)        default(""), not null, primary key
#  fcustno          :string(6)        default(""), not null
#  fcompany         :string(35)       default(""), not null
#  fcity            :string(20)       default(""), not null
#  fcustpono        :string(20)       default(""), not null
#  fackdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcanc_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fccurid          :string(3)        default(""), not null
#  fcfactor         :decimal(17, 5)   default(0.0), not null
#  fcfname          :string(15)       default(""), not null
#  fcfromno         :string(25)       default("")
#  fcfromtype       :string(5)        default(""), not null
#  fcontact         :string(30)       default(""), not null
#  fclos_dt         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcountry         :string(25)       default(""), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fdcurdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fdisrate         :decimal(8, 3)    default(0.0), not null
#  fdistno          :string(6)        default(""), not null
#  fduedate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fduplicate       :boolean          default(FALSE), not null
#  fdusrdate1       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  festimator       :string(3)        default(""), not null
#  ffax             :string(20)       default(""), not null
#  ffob             :string(20)       default(""), not null
#  fnextenum        :string(3)        default(""), not null
#  fnextinum        :string(3)        default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  forderdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fordername       :string(35)       default(""), not null
#  fordrevdt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fpaytype         :string(1)        default(""), not null
#  fphone           :string(20)       default(""), not null
#  fprint_dt        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fprinted         :boolean          default(FALSE), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fsalecom         :boolean          default(FALSE), not null
#  fshipvia         :string(20)       default(""), not null
#  fshptoaddr       :string(4)        default(""), not null
#  fsocoord         :string(3)        default(""), not null
#  fsoldaddr        :string(4)        default(""), not null
#  fsoldby          :string(3)        default(""), not null
#  fsorev           :string(2)        default(""), not null
#  fstate           :string(20)       default(""), not null
#  fstatus          :string(20)       default(""), not null
#  ftaxcode         :string(3)        default(""), not null
#  ftaxrate         :decimal(7, 3)    default(0.0), not null
#  fterm            :string(4)        default(""), not null
#  fterr            :string(10)       default(""), not null
#  fzip             :string(10)       default(""), not null
#  flprofprtd       :boolean          default(FALSE), not null
#  flprofrqd        :boolean          default(FALSE), not null
#  fndpstrcvd       :decimal(17, 5)   default(0.0), not null
#  fndpstrqd        :decimal(17, 5)   default(0.0), not null
#  fdeurodate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fsalescode       :string(7)        default(""), not null
#  fusercode        :string(7)        default(""), not null
#  fncancchrge      :decimal(17, 5)   default(0.0), not null
#  flchgpnd         :boolean          default(FALSE), not null
#  fllasteco        :string(25)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fackmemo         :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fmusrmemo1       :text             default(""), not null
#  fccontkey        :string(10)       default(""), not null
#  flcontract       :boolean          default(FALSE), not null
#  fndbrmod         :integer          default(0), not null
#  fccommcode       :string(10)       default(""), not null
#  fpriority        :integer          default(4), not null
#  ContractNu       :string(10)       default(""), not null
#  fbilladdr        :string(4)        default(""), not null
#  OpportunNum      :string(6)        default(""), not null
#  CreatedDate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ModifiedDate     :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  OppCrType        :string(3)        default(""), not null
#  QuoteNumber      :string(6)        default(""), not null
#

class M2m::SalesOrder < M2m::Base
  self.table_name = 'somast'
  set_primary_key 'fsono'
  
  has_many :items, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fsono, :primary_key => :fsono
  has_many :releases, :class_name => 'M2m::SalesOrderRelease', :foreign_key => :fsono, :primary_key => :fsono
  has_one :customer, :class_name => 'M2m::Customer', :foreign_key => :fcustno, :primary_key => :fcustno
  has_many :invoices, :class_name => 'M2m::Invoice', :foreign_key => :fsono, :primary_key => :fsono
  
  scope :status_open,      :conditions => { :fstatus => M2m::Status.open.name }
  scope :status_closed,    :conditions => { :fstatus => M2m::Status.closed.name }
  scope :status_cancelled, :conditions => { :fstatus => M2m::Status.cancelled.name }
  
  scope :by_order_number_desc, :order => 'somast.fsono desc'  
  scope :by_due_date, :order => 'somast.fduedate'
  scope :by_order_date, :order => 'somast.forderdate'
  
  # scope :since, lambda { |day|
  #   {
  #     :conditions => ['somast.forderdate >= ?', day],
  #     :include => [:releases, :items], 
  #     :order => 'forderdate desc, fsono desc'
  #   }
  # }
  scope :order_dates, lambda { |start_date, end_date|
    start_date = start_date.is_a?(String) ? Date.parse(start_date) : start_date
    end_date = end_date.is_a?(String) ? Date.parse(end_date) : end_date
    {
      :conditions => [ 'somast.forderdate >= ? and somast.forderdate < ?', start_date, end_date ]
    }
  }
  scope :ordered_since, lambda { |day|
    {
      :conditions => ['somast.forderdate >= ?', day],
    }
  }
  scope :with_order_number, lambda { |order_number|
    {
      :conditions => { :fsono => order_number }
    }
  }
  scope :with_order_numbers, lambda { |order_numbers|
    {
      :conditions => [ 'somast.fsono in (?)', order_numbers ]
    }
  }
  scope :prepayment_required, :conditions => { :flprofrqd => true }
  scope :customer, lambda { |customer|
    customer_number = customer.is_a?(M2m::Customer) ? customer.customer_number : customer
    {
      :conditions => { :fcustno => customer_number }
    }
  }
  scope :customers, lambda { |customers|
    customer_numbers = customers.map(&:customer_number)
    {
      :conditions => [ 'somast.fcustno in (?)', customer_numbers ]
    }
  }
  
  alias_attribute :order_number, :fsono
  alias_attribute :order_date, :forderdate
  alias_attribute :customer_po, :fcustpono
  alias_attribute :due_date, :fduedate
  alias_attribute :ship_via, :fshipvia
  alias_attribute :prepayment_required, :flprofrqd
  alias_attribute :customer_number, :fcustno
  alias_attribute :commission_percentage, :fsalcompct
  alias_attribute :sales_person, :fsoldby
  
  def customer_name
    M2m::Customer.customer_name(self.fcompany)
  end
  
  def total_price
    self.items.to_a.sum { |i| i.total_price || 0.0 }
  end
  
  def status
    M2m::Status.find_by_name(self.fstatus)
  end
  
  def closed?
    self.status.try(:closed?)
  end
  
  # Default to customer sales master
  def fob
    self.ffob.present? ? self.ffob.strip : self.customer.ffob
  end

  def self.attach_sales_orders(objects)
    sales_orders = M2m::SalesOrder.with_order_numbers(objects.map(&:sales_order_number).uniq).scoped(:include => :items)
    sales_order_hash = {}
    sales_orders.each { |so| sales_order_hash[so.order_number] = so }
    objects.each do |o|
      if o.sales_order_number.present? and (found = sales_order_hash[o.sales_order_number])
        o.sales_order = found
      else
        # Explicitly set to prevent lazy load
        o.sales_order = nil
      end
    end
    sales_orders
  end
  
  def self.pad_sales_order_number(txt)
    "%06d" % txt.to_i
  end
end

