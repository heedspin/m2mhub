# == Schema Information
#
# Table name: aritem
#
#  fbkordqty        :decimal(15, 5)   default(0.0), not null
#  fcinvoice        :char(20)         default("                    "), not null
#  fcost            :money            default(0.0), not null
#  fctype           :char(1)          default(" "), not null
#  fcustno          :char(6)          default("      "), not null
#  fctaxcode        :char(10)         default("          "), not null
#  fcuserline       :char(10)         default("          "), not null
#  fdiscamt         :money            default(0.0), not null
#  fdisrate         :decimal(17, 5)   default(0.0), not null
#  fincacc          :char(25)         default("                         "), not null
#  fitem            :char(6)          default("      "), not null
#  flcomm           :boolean          default(FALSE), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fmeasure         :char(3)          default("   "), not null
#  fordqty          :decimal(15, 5)   default(0.0), not null
#  fpartno          :char(25)         default("                         "), not null
#  frev             :char(3)          default("   "), not null
#  fprice           :decimal(17, 5)   default(0.0), not null
#  fprodcl          :varchar(4)       default(""), not null
#  frecvkey         :varchar(13)      default(""), not null
#  fsalesacc        :char(25)         default("                         "), not null
#  fshipkey         :varchar(16)      default(""), not null
#  fshipqty         :decimal(15, 5)   default(0.0), not null
#  fsokey           :varchar(16)      default(""), not null
#  fsoldby          :char(3)          default("   "), not null
#  ftotprice        :money            default(0.0), not null
#  fdisceuramt      :money            default(0.0), not null
#  fdisctxnamt      :money            default(0.0), not null
#  feuroprice       :decimal(17, 5)   default(0.0), not null
#  ftoteurprice     :money            default(0.0), not null
#  ftottxnprice     :money            default(0.0), not null
#  ftxnprice        :decimal(17, 5)   default(0.0), not null
#  fljrdif          :boolean          default(FALSE), not null
#  fncompct         :decimal(8, 3)    default(0.0), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmdescript       :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fpbitem          :char(3)          default("   "), not null
#  fpbfinal         :boolean          default(FALSE), not null
#  fcudrev          :char(3)          default("   "), not null
#  ContractNu       :varchar(10)      default(""), not null
#  fnRestock        :money            default(0.0), not null
#  fnMiscamt        :money            default(0.0), not null
#  fcrmakey         :char(28)         default("                            "), not null
#  fntxnmiscamt     :decimal(16, 5)   default(0.0), not null
#  fntxnrestock     :decimal(16, 5)   default(0.0), not null
#  FRECEIVER        :varchar(10)      default(""), not null
#  FRECVITEMNO      :varchar(3)       default(""), not null
#  FTAXITEMNO       :varchar(6)       default(""), not null
#  FCSONO           :varchar(10)      default(""), not null
#  FINUMBER         :varchar(3)       default(""), not null
#  FRELEASE         :varchar(3)       default(""), not null
#  FSHIPNO          :varchar(10)      default(""), not null
#  FSHIPITEMNO      :varchar(6)       default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::InvoiceItem < M2m::Base
  self.table_name = 'aritem'

  belongs_to :invoice, :class_name => 'M2m::Invoice', :foreign_key => 'fcinvoice', :primary_key => 'fcinvoice'
  belongs_to_item :fpartno, :frev
  belongs_to :customer, :class_name => 'M2m::Customer', :foreign_key => 'fcustno', :primary_key => 'fcustno'
  belongs_to :sales_gl_account, :class_name => 'M2m::GlAccount', :foreign_key => 'fincacc', :primary_key => 'fcacctnum'

  alias_attribute :rma_key, :fcrmakey
  alias_attribute :amount, :ftotprice
  alias_attribute :invoice_number, :fcinvoice
  alias_attribute :ship_quantity, :fshipqty
  alias_attribute :unit_price, :fprice
  alias_attribute :description, :fmdescript
  alias_attribute :customer_number, :fcustno
  alias_attribute :invoice_item_type, :fctype
  alias_attribute :sales_gl_account_number, :fincacc

  scope :part_number, -> (pn) { where(:fpartno => pn) }
  scope :revision, -> (r) { where(:frev => r) }
  scope :for_rma_item, -> (rma_item) {
    where :fcrmakey => M2m::InvoiceItem.rma_key(rma_item)
  }
  scope :for_rma_items, -> (rma_items) {
    where [ 'aritem.fcrmakey in (?)', rma_items.map { |ri| M2m::InvoiceItem.rma_key(ri) } ]
  }
  scope :customer, -> (customer) {
    custno = customer.is_a?(M2m::Customer) ? customer.customer_number : customer
    joins(:invoice).
    where(:armast => {:fcustno => custno})
  }
  scope :customers, -> (customer_numbers) {
    customer_numbers = customer_numbers.map { |t| M2m::Customer.fcustno_for(t) }
    joins(:invoice).
    where([ 'armast.fcustno in (?)', customer_numbers ])
  }
  def self.invoice_dates(start_date, end_date)
    start_date = DateParser.parse(start_date) unless start_date.is_a?(Date)
    end_date = DateParser.parse(end_date) unless end_date.is_a?(Date)
    joins(:invoice).where(['armast.finvdate >= ? and armast.finvdate < ?', start_date, end_date])
  end
  def self.post_dates(start_date, end_date)
    start_date = DateParser.parse(start_date) unless start_date.is_a?(Date)
    end_date = DateParser.parse(end_date) unless end_date.is_a?(Date)
    joins(:invoice).where(['armast.fdgldate >= ? and armast.fdgldate < ?', start_date, end_date])
  end
  # TODO: Replace 'V' with something intelligent?
  scope :not_void, -> { joins(:invoice).where([ 'armast.fcstatus != ? ', 'V' ]) }
  scope :unpaid_or_partial, -> { joins(:invoice).where([ 'armast.fcstatus in (?)', ['U', 'P'] ]) }
  scope :unpaid, -> { joins(:invoice).where([ 'armast.fcstatus in (?)', ['U'] ]) }
  scope :partial, -> { joins(:invoice).where([ 'armast.fcstatus in (?)', ['P'] ]) }
  scope :normal_type, -> { joins(:invoice).where([ 'armast.finvtype = ?', 'N' ]) }
  scope :credit_memo, -> { joins(:invoice).where([ 'armast.finvtype = ?', 'C' ]) }
  scope :prepayment, -> { joins(:invoice).where([ 'armast.finvtype = ?', 'P' ]) }
  scope :gl_category, -> (code) {
    joins(:sales_gl_account).
    where(:glmast => { :fccode => code })
  }
  # S - Sales, F - Freight, P - Proforma
  def self.item_types(*types)
    where 'aritem.fctype in (?)', types
  end

  def invoice_number
    self.fcinvoice.strip
  end

  def clean_invoice_number
    if self.fcinvoice =~ /^\W*(\w\w)-(\d+)\W*$/
      $1 + '-' + $2.to_i.to_s
    else
      self.fcinvoice.strip
    end
  end

  def item_number
    self.fitem.strip
  end

  def clean_item_number
    self.item_number.to_i.to_s
  end

  def sales_order
    unless @_loaded_sales_order
      if self.sales_order_number.present?
        @sales_order = M2m::SalesOrder.with_order_number(self.sales_order_number).first
        @_loaded_sales_order = true
      end
    end
    @sales_order
  end
  def sales_order=(val)
    @_loaded_sales_order = true
    @sales_order = val
  end

  def sales_order_number
    @sales_order_number ||= self.fsokey[0..5]
  end

  def sales_order_release_id
    @sales_order_release_id ||= self.fsokey[6..8]
  end

  def sales_order_release_number
    @sales_order_release_number ||= self.fsokey[9..11]
  end

  def customer_part_number
    if (so = self.sales_order) and (sales_order_item = so.items.detect { |soi| soi.part_number == self.part_number })
      sales_order_item.customer_part_number
    else
      nil
    end
  end

  def rma_number
    M2m::InvoiceItem.rma_number(self.rma_key)
  end
  def self.rma_number(rma_key)
    return nil unless rma_key.present?
    rma_key[0..14].to_i
  end
  def rma_item_number
    M2m::InvoiceItem.rma_item_number(self.rma_key)
  end
  def self.rma_item_number(rma_key)
    return nil unless rma_key.present?
    rma_key[15..-1].to_i
  end
  def self.rma_key(rma_item)
    # Zero pad and space pad.
    ("%015d" % rma_item.rma_number) + ("% 3d" % rma_item.item_number.to_i)
  end
  def rma_item=(rma_item)
    self.rma_key = M2m::InvoiceItem.rma_key(rma_item)
  end
  def for_rma_item?(rma_item)
    self.rma_key.strip == M2m::InvoiceItem.rma_key(rma_item)
  end

  def vendors
    @vendors ||= M2m::InventoryVendor.for_item(self)
  end
end
