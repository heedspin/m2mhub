# == Schema Information
#
# Table name: qtitem
#
#  fenumber         :string(3)        default(""), not null
#  finumber         :string(3)        default(""), not null
#  fpartno          :string(25)       default(""), not null
#  fpartrev         :string(3)        default(""), not null
#  fquoteno         :string(6)        default(""), not null
#  fbomqty          :decimal(15, 5)   default(0.0), not null
#  fcfromitem       :string(3)        default(""), not null
#  fcfromno         :string(6)        default(""), not null
#  fcfromtype       :string(5)        default(""), not null
#  fcustpart        :string(25)       default(""), not null
#  fcustptrev       :string(3)        default(""), not null
#  fcas_bom         :boolean          default(FALSE), not null
#  fcas_rtg         :boolean          default(FALSE), not null
#  fdet_bom         :boolean          default(FALSE), not null
#  fdet_rtg         :boolean          default(FALSE), not null
#  festqty          :decimal(15, 5)   default(0.0), not null
#  ffixact          :decimal(21, 8)   default(0.0), not null
#  fgroup           :string(6)        default(""), not null
#  flabact          :decimal(17, 5)   default(0.0), not null
#  flordered        :boolean          default(FALSE), not null
#  fmatlact         :decimal(17, 5)   default(0.0), not null
#  fovhdact         :decimal(17, 5)   default(0.0), not null
#  fmeasure         :string(3)        default(""), not null
#  fnextinum        :integer          default(0), not null
#  fothract         :decimal(17, 5)   default(0.0), not null
#  fprintmemo       :boolean          default(FALSE), not null
#  fprodcl          :string(2)        default(""), not null
#  frtgsetupa       :decimal(17, 5)   default(0.0), not null
#  fschecode        :string(6)        default(""), not null
#  fsetupact        :decimal(17, 5)   default(0.0), not null
#  fsono            :string(6)        default(""), not null
#  fsource          :string(1)        default(""), not null
#  fstandpart       :boolean          default(FALSE), not null
#  fsubact          :decimal(17, 5)   default(0.0), not null
#  ftoolact         :decimal(17, 5)   default(0.0), not null
#  ftotptime        :decimal(17, 5)   default(0.0), not null
#  ftotstime        :decimal(17, 5)   default(0.0), not null
#  fulabcost        :decimal(17, 5)   default(0.0), not null
#  funetprice       :decimal(17, 5)   default(0.0), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fclotext         :string(1)        default(""), not null
#  fcprodid         :string(6)        default(""), not null
#  funettxnpric     :decimal(17, 5)   default(0.0), not null
#  funeteuropr      :decimal(17, 5)   default(0.0), not null
#  fschedtype       :string(1)        default(""), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fljrdif          :boolean          default(FALSE), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fdelivery        :text             default(""), not null
#  fdesc            :text             default(""), not null
#  fdescmemo        :text             default(""), not null
#  fac              :string(20)       default(""), not null
#  sfac             :string(20)       default(""), not null
#  fcpbtype         :string(1)        default(""), not null
#  ITCCOST          :decimal(17, 5)   default(0.0), not null
#  fcudrev          :string(3)        default(""), not null
#  fndbrmod         :integer          default(0), not null
#  fctpdate         :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fctptrans        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ContractNu       :string(10)       default(""), not null
#  Flrfqreqd        :boolean          default(FALSE), not null
#  Fcostfrom        :string(9)        default(""), not null
#

class M2m::QuoteItem < M2m::Base
  default_scope -> { order('qtitem.fenumber') }
  self.table_name = 'qtitem'
  belongs_to :quote, :class_name => 'M2m::Quote', :foreign_key => :fquoteno, :primary_key => :fquoteno
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono, :primary_key => :fsono
  belongs_to_item :fpartno, :fpartrev
  
  scope :status_open,      :joins => :quote, :conditions => {:qtmast => { :fstatus => M2m::Status.open.name }}
  scope :status_closed,    :joins => :quote, :conditions => {:qtmast => { :fstatus => M2m::Status.closed.name }}
  scope :status_cancelled, :joins => :quote, :conditions => {:qtmast => { :fstatus => M2m::Status.cancelled.name }}
  
  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision } 
    }
  }

  scope :with_status, lambda { |status|
    status_name = status.is_a?(M2m::Status) ? status.name : status.to_s
    {
      :joins => :quote, 
      :conditions => { :qtmast => { :fstatus => status_name.upcase } }
    }
  }
  
  scope :rev_order, -> { order('fsono desc, fenumber') }


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


