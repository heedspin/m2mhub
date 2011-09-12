class M2m::QuoteItem < M2m::Base
  default_scope :order => :fenumber
  set_table_name 'qtitem'
  belongs_to :quote, :foreign_key => :fquoteno, :primary_key => :fquoteno
  belongs_to :item, :foreign_key => :fpartno, :primary_key => :fpartno
  belongs_to :sales_order, :foreign_key => :fsono, :primary_key => :fsono
  
  alias_attribute :quantity, :festqty
  alias_attribute :unit_price, :funetprice
  alias_attribute :sales_order_number, :fsono
  def part_number
    self.fpartno.strip
  end
end

# == Schema Information
#
# Table name: qtitem
#
#  fenumber         :string(3)       not null
#  finumber         :string(3)       not null
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  fquoteno         :string(6)       not null
#  fbomqty          :decimal(15, 5)  not null
#  fcfromitem       :string(3)       not null
#  fcfromno         :string(6)       not null
#  fcfromtype       :string(5)       not null
#  fcustpart        :string(25)      not null
#  fcustptrev       :string(3)       not null
#  fcas_bom         :boolean         not null
#  fcas_rtg         :boolean         not null
#  fdet_bom         :boolean         not null
#  fdet_rtg         :boolean         not null
#  festqty          :decimal(15, 5)  not null
#  ffixact          :decimal(21, 8)  not null
#  fgroup           :string(6)       not null
#  flabact          :decimal(21, 8)  not null
#  flordered        :boolean         not null
#  fmatlact         :decimal(17, 5)  not null
#  fovhdact         :decimal(17, 5)  not null
#  fmeasure         :string(3)       not null
#  fnextinum        :integer         not null
#  fothract         :decimal(17, 5)  not null
#  fprintmemo       :boolean         not null
#  fprodcl          :string(2)       not null
#  frtgsetupa       :decimal(17, 5)  not null
#  fschecode        :string(6)       not null
#  fsetupact        :decimal(17, 5)  not null
#  fsono            :string(6)       not null
#  fsource          :string(1)       not null
#  fstandpart       :boolean         not null
#  fsubact          :decimal(17, 5)  not null
#  ftoolact         :decimal(17, 5)  not null
#  ftotptime        :decimal(17, 5)  not null
#  ftotstime        :decimal(17, 5)  not null
#  fulabcost        :decimal(7, 2)   not null
#  funetprice       :decimal(17, 5)  not null
#  fllotreqd        :boolean         not null
#  fclotext         :string(1)       not null
#  fcprodid         :string(6)       not null
#  funettxnpric     :decimal(17, 5)  not null
#  funeteuropr      :decimal(17, 5)  not null
#  fschedtype       :string(1)       not null
#  flistaxabl       :boolean         not null
#  fljrdif          :boolean         not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdelivery        :text            default(" "), not null
#  fdesc            :text            default(" "), not null
#  fdescmemo        :text            default(" "), not null
#  fac              :string(20)      not null
#  sfac             :string(20)      not null
#  fcpbtype         :string(1)       default(""), not null
#  ITCCOST          :decimal(17, 5)  not null
#  fcudrev          :string(3)       default(" "), not null
#  fndbrmod         :integer(1)      not null
#  fctpdate         :datetime        not null
#  fctptrans        :datetime        not null
#

