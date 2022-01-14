# == Schema Information
#
# Table name: qtitem
#
#  fenumber         :char(3)          default("   "), not null
#  finumber         :char(3)          default("   "), not null
#  fpartno          :char(25)         default("                         "), not null
#  fpartrev         :char(3)          default("   "), not null
#  fquoteno         :varchar(10)      default(""), not null
#  fbomqty          :decimal(15, 5)   default(0.0), not null
#  fcfromitem       :char(3)          default("   "), not null
#  fcfromno         :varchar(25)      default(""), not null
#  fcfromtype       :char(5)          default("     "), not null
#  fcustpart        :char(25)         default("                         "), not null
#  fcustptrev       :char(3)          default("   "), not null
#  fcas_bom         :boolean          default(FALSE), not null
#  fcas_rtg         :boolean          default(FALSE), not null
#  fdet_bom         :boolean          default(FALSE), not null
#  fdet_rtg         :boolean          default(FALSE), not null
#  festqty          :decimal(15, 5)   default(0.0), not null
#  ffixact          :decimal(21, 8)   default(0.0), not null
#  fgroup           :char(6)          default("      "), not null
#  flabact          :decimal(17, 5)   default(0.0), not null
#  flordered        :boolean          default(FALSE), not null
#  fmatlact         :decimal(17, 5)   default(0.0), not null
#  fovhdact         :decimal(17, 5)   default(0.0), not null
#  fmeasure         :char(3)          default("   "), not null
#  fnextinum        :integer          default(0), not null
#  fothract         :decimal(17, 5)   default(0.0), not null
#  fprintmemo       :boolean          default(FALSE), not null
#  fprodcl          :varchar(4)       default(""), not null
#  frtgsetupa       :decimal(17, 5)   default(0.0), not null
#  fschecode        :char(6)          default("      "), not null
#  fsetupact        :decimal(17, 5)   default(0.0), not null
#  fsono            :varchar(10)      default(""), not null
#  fsource          :char(1)          default(" "), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fsubact          :decimal(17, 5)   default(0.0), not null
#  ftoolact         :decimal(17, 5)   default(0.0), not null
#  ftotptime        :decimal(17, 5)   default(0.0), not null
#  ftotstime        :decimal(17, 5)   default(0.0), not null
#  fulabcost        :decimal(17, 5)   default(0.0), not null
#  funetprice       :decimal(17, 5)   default(0.0), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :char(1)          default(" "), not null
#  fcprodid         :char(6)          default("      "), not null
#  funettxnpric     :decimal(17, 5)   default(0.0), not null
#  funeteuropr      :decimal(17, 5)   default(0.0), not null
#  fschedtype       :char(1)          default(" "), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fljrdif          :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fdelivery        :varchar_max(2147 default(""), not null
#  fdesc            :varchar_max(2147 default(""), not null
#  fdescmemo        :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  sfac             :char(20)         default("                    "), not null
#  fcpbtype         :char(1)          default(" "), not null
#  ITCCOST          :decimal(17, 5)   default(0.0), not null
#  fndbrmod         :integer          default(0), not null
#  fcudrev          :char(3)          default("   "), not null
#  fctpdate         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fctptrans        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ContractNu       :varchar(10)      default(""), not null
#  Flrfqreqd        :boolean          default(FALSE), not null
#  Fcostfrom        :varchar(10)      default(""), not null
#  Isordered        :boolean
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::QuoteItem < M2m::Base
  default_scope -> { order('qtitem.fenumber') }
  self.table_name = 'qtitem'
  belongs_to :quote, :class_name => 'M2m::Quote', :foreign_key => :fquoteno, :primary_key => :fquoteno
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono, :primary_key => :fsono
  belongs_to_item :fpartno, :fpartrev
  
  scope :status_open,      -> { joins(:quote).where(:qtmast => { :fstatus => M2m::Status.open.name }) }
  scope :status_closed,    -> { joins(:quote).where(:qtmast => { :fstatus => M2m::Status.closed.name }) }
  scope :status_cancelled, -> { joins(:quote).where(:qtmast => { :fstatus => M2m::Status.cancelled.name }) }
  
  scope :for_item, -> (item) {
    where :fpartno => item.part_number, :fpartrev => item.revision
  }

  scope :with_status, -> (status) {
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    joins(:quote).
    where(:qtmast => { :fstatus => status_name.upcase })
  }
  
  scope :rev_order, -> { order('qtitem.fsono desc, qtitem.fenumber') }


  alias_attribute :quantity, :festqty
  alias_attribute :unit_price, :funetprice
  alias_attribute :sales_order_number, :fsono
  alias_attribute :item_number, :fenumber
  alias_attribute :customer_part_number, :fcustpart
  alias_attribute :description, :fdesc
  
  def total_price
    self.unit_price * self.quantity
  end
end


