class M2m::SalesOrderRelease < M2m::Base
  default_scope :order => :fenumber
  set_table_name 'sorels'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
  belongs_to :item, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fsono, :primary_key => :fsono, :conditions => 'soitem.fenumber = \'#{fenumber}\''

  named_scope :by_due_date, :order => :fduedate

  # This does not work because belongs_to :item fails: "undefined local variable or method `fenumber'"
  # named_scope :not_masters, :joins => :item, :conditions => 'soitem.fmultiple = 0 OR sorels.frelease != \'000\''
  
  def quantity
    self.forderqty > 0 ? self.forderqty : self.item.quantity
  end
  
  def release_price
    self.quantity * self.unit_price
  end
  
  alias_attribute :due_date, :fduedate
  alias_attribute :unit_price, :funetprice
  alias_attribute :total_price, :fnetprice
  
  # Optimization to avoid the inefficiency of the belongs_to above.
  def attach_items_from_sales_order(sales_order)
    self.item = sales_order.items.detect { |i| i.fenumber == self.fenumber }
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
#  fcbin            :string(14)      not null
#  fcloc            :string(14)      not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdelivery        :text            default(" "), not null
#  fcpbtype         :string(1)       default(""), not null
#  fcudrev          :string(3)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#  fpriority        :integer(4)      default(4), not null
#  SchedDate        :datetime        not null
#

