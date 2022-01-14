# == Schema Information
#
# Table name: somast
#
#  fsono            :varchar(10)      default(""), not null, primary key
#  fcustno          :char(6)          default("      "), not null
#  fcompany         :varchar(35)      default(""), not null
#  fcity            :char(20)         default("                    "), not null
#  fcustpono        :char(20)         default("                    "), not null
#  fackdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcanc_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fccurid          :char(3)          default("   "), not null
#  fcfactor         :decimal(22, 10)  default(0.0), not null
#  fcfname          :char(15)         default("               "), not null
#  fcfromno         :char(25)         default("                         ")
#  fcfromtype       :char(5)          default("     "), not null
#  fcontact         :varchar(30)      default(""), not null
#  fclos_dt         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcountry         :char(25)         default("                         "), not null
#  fcusrchr1        :char(20)         default("                    "), not null
#  fcusrchr2        :varchar(40)      default(""), not null
#  fcusrchr3        :varchar(40)      default(""), not null
#  fdcurdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdisrate         :decimal(8, 3)    default(0.0), not null
#  fdistno          :char(6)          default("      "), not null
#  fduedate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fduplicate       :boolean          default(FALSE), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  festimator       :char(3)          default("   "), not null
#  ffax             :char(20)         default("                    "), not null
#  ffob             :char(20)         default("                    "), not null
#  fnextenum        :char(3)          default("   "), not null
#  fnextinum        :char(3)          default("   "), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  forderdate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fordername       :varchar(65)      default(""), not null
#  fordrevdt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fpaytype         :char(1)          default(" "), not null
#  fphone           :char(20)         default("                    "), not null
#  fprint_dt        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fprinted         :boolean          default(FALSE), not null
#  fsalcompct       :decimal(8, 3)    default(0.0), not null
#  fsalecom         :boolean          default(FALSE), not null
#  fshipvia         :char(20)         default("                    "), not null
#  fshptoaddr       :varchar(6)       default(""), not null
#  fsocoord         :char(3)          default("   "), not null
#  fsoldaddr        :varchar(6)       default(""), not null
#  fsoldby          :char(3)          default("   "), not null
#  fsorev           :char(2)          default("  "), not null
#  fstate           :char(20)         default("                    "), not null
#  fstatus          :char(20)         default("                    "), not null
#  ftaxcode         :char(3)          default("   "), not null
#  ftaxrate         :decimal(7, 3)    default(0.0), not null
#  fterm            :char(4)          default("    "), not null
#  fterr            :char(10)         default("          "), not null
#  fzip             :char(10)         default("          "), not null
#  flprofprtd       :boolean          default(FALSE), not null
#  flprofrqd        :boolean          default(FALSE), not null
#  fndpstrcvd       :decimal(17, 5)   default(0.0), not null
#  fndpstrqd        :decimal(17, 5)   default(0.0), not null
#  fdeurodate       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  feurofctr        :decimal(17, 5)   default(0.0), not null
#  fsalescode       :char(7)          default("       "), not null
#  fusercode        :char(7)          default("       "), not null
#  fncancchrge      :decimal(17, 5)   default(0.0), not null
#  flchgpnd         :boolean          default(FALSE), not null
#  fllasteco        :char(25)         default("                         "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null
#  fackmemo         :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fmusrmemo1       :varchar_max(2147 default(""), not null
#  fccontkey        :char(10)         default("          "), not null
#  flcontract       :boolean          default(FALSE), not null
#  fndbrmod         :integer          default(0), not null
#  fccommcode       :char(10)         default("          "), not null
#  fpriority        :integer          default(4), not null
#  ContractNu       :varchar(10)      default(""), not null
#  fbilladdr        :varchar(6)       default(""), not null
#  OpportunNum      :varchar(10)      default(""), not null
#  CreatedDate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ModifiedDate     :datetime         default(1900-01-01 00:00:00 UTC), not null
#  OppCrType        :char(3)          default("   "), not null
#  QuoteNumber      :varchar(10)      default(""), not null
#  contactnum       :varchar(6)       default(""), not null
#  flpaybycc        :boolean          default(FALSE), not null
#

class M2m::SalesOrder < M2m::Base
  self.table_name = 'somast'
  self.primary_key = 'fsono'
  
  has_many :items, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fsono, :primary_key => :fsono
  has_many :releases, :class_name => 'M2m::SalesOrderRelease', :foreign_key => :fsono, :primary_key => :fsono
  has_one :customer, :class_name => 'M2m::Customer', :foreign_key => :fcustno, :primary_key => :fcustno
  has_many :invoices, :class_name => 'M2m::Invoice', :foreign_key => :fsono, :primary_key => :fsono
  belongs_to :sales_person, :class_name => 'M2m::SalesPerson', :foreign_key => :fsoldby, :primary_key => :fsalespn
  
  scope :status_open, -> { where(fstatus: M2m::Status.open.name) }
  scope :status_closed, -> { where(fstatus: M2m::Status.closed.name) }
  scope :status_cancelled, -> { where(fstatus: M2m::Status.cancelled.name) }
  
  scope :by_order_number_desc, -> { order('somast.fsono desc') }
  scope :by_order_number, -> { order :fsono }
  scope :by_due_date, -> { order('somast.fduedate') }
  scope :by_order_date, -> { order('somast.forderdate') }
  
  scope :order_dates, -> (start_date, end_date) {
    start_date = start_date.is_a?(String) ? DateParser.parse(start_date) : start_date
    end_date = end_date.is_a?(String) ? DateParser.parse(end_date) : end_date
    where [ 'somast.forderdate >= ? and somast.forderdate < ?', start_date, end_date ]
  }
  scope :ordered_since, -> (day) {
    where ['somast.forderdate >= ?', day]
  }
  scope :with_order_number, -> (order_number) {
    where :fsono => order_number
  }
  scope :with_order_numbers, -> (order_numbers) {
    where [ 'somast.fsono in (?)', order_numbers ]
  }
  scope :sono_before, -> (sono) {
    where ['somast.fsono < ?', sono]
  }
  scope :sono_after, -> (sono) {
    where ['somast.fsono > ?', sono]
  }

  scope :prepayment_required, -> { where(flprofrqd: true) }
  scope :customer, -> (customer) {
    customer_number = customer.is_a?(M2m::Customer) ? customer.customer_number : customer
    where :fcustno => customer_number
  }
  scope :customers, -> (customers) {
    customer_numbers = customers.map(&:customer_number)
    where [ 'somast.fcustno in (?)', customer_numbers ]
  }
  
  alias_attribute :order_number, :fsono
  alias_attribute :order_date, :forderdate
  alias_attribute :customer_po, :fcustpono
  alias_attribute :due_date, :fduedate
  alias_attribute :ship_via, :fshipvia
  alias_attribute :prepayment_required, :flprofrqd
  alias_attribute :customer_number, :fcustno
  alias_attribute :commission_percentage, :fsalcompct
  alias_attribute :sales_person_key, :fsoldby
  
  def customer_name
    M2m::Customer.customer_name(self.fcompany)
  end
  
  def total_price
    self.releases.to_a.sum { |i| i.total_price || 0.0 }
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
    sales_orders = M2m::SalesOrder.with_order_numbers(objects.map(&:sales_order_number).uniq).includes(:items)
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

  def ship_to_address
    @ship_to_address ||= self.customer.addresses.key(self.fshptoaddr).first
  end
  def bill_to_address
    @bill_to_address ||= self.customer.addresses.key(self.fbilladdr).first
  end
end

