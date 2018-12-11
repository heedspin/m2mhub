# == Schema Information
#
# Table name: inmastx
#
#  fpartno          :string(25)       default(""), not null
#  frev             :string(3)        default(""), not null
#  fcstscode        :string(1)        default(""), not null
#  fdescript        :string(35)       default(""), not null
#  flchgpnd         :boolean          default(FALSE), not null
#  fmeasure         :string(3)        default(""), not null
#  fsource          :string(1)        default(""), not null
#  fleadtime        :decimal(7, 1)    default(0.0), not null
#  fprice           :decimal(17, 5)   default(0.0), not null
#  fstdcost         :decimal(17, 5)   default(0.0), not null
#  f2totcost        :decimal(17, 5)   default(0.0), not null
#  flastcost        :decimal(17, 5)   default(0.0), not null
#  flocate1         :string(14)       default(""), not null
#  fbin1            :string(14)       default(""), not null
#  f2costcode       :string(1)        default(""), not null
#  f2displcst       :decimal(17, 5)   default(0.0), not null
#  f2dispmcst       :decimal(17, 5)   default(0.0), not null
#  f2dispocst       :decimal(17, 5)   default(0.0), not null
#  f2disptcst       :decimal(17, 5)   default(0.0), not null
#  f2labcost        :decimal(17, 5)   default(0.0), not null
#  f2matlcost       :decimal(17, 5)   default(0.0), not null
#  f2ovhdcost       :decimal(17, 5)   default(0.0), not null
#  favgcost         :decimal(17, 5)   default(0.0), not null
#  fbulkissue       :string(1)        default(""), not null
#  fbuyer           :string(3)        default(""), not null
#  fcalc_lead       :string(1)        default(""), not null
#  fcbackflsh       :string(1)        default(""), not null
#  fcnts            :integer          default(0), not null
#  fcopymemo        :string(1)        default(""), not null
#  fcostcode        :string(1)        default(""), not null
#  fcpurchase       :string(1)        default(""), not null
#  fcstperinv       :decimal(13, 9)   default(0.0), not null
#  fdisplcost       :decimal(17, 5)   default(0.0), not null
#  fdispmcost       :decimal(17, 5)   default(0.0), not null
#  fdispocost       :decimal(17, 5)   default(0.0), not null
#  fdispprice       :decimal(17, 5)   default(0.0), not null
#  fdisptcost       :decimal(17, 5)   default(0.0), not null
#  fdrawno          :string(25)       default(""), not null
#  fdrawsize        :string(2)        default(""), not null
#  fendqty1         :decimal(15, 5)   default(0.0), not null
#  fendqty10        :decimal(17, 5)   default(0.0), not null
#  fendqty11        :decimal(17, 5)   default(0.0), not null
#  fendqty12        :decimal(17, 5)   default(0.0), not null
#  fendqty2         :decimal(17, 5)   default(0.0), not null
#  fendqty3         :decimal(17, 5)   default(0.0), not null
#  fendqty4         :decimal(17, 5)   default(0.0), not null
#  fendqty5         :decimal(17, 5)   default(0.0), not null
#  fendqty6         :decimal(17, 5)   default(0.0), not null
#  fendqty7         :decimal(17, 5)   default(0.0), not null
#  fendqty8         :decimal(17, 5)   default(0.0), not null
#  fendqty9         :decimal(17, 5)   default(0.0), not null
#  fgroup           :string(6)        default(""), not null
#  finspect         :string(1)        default(""), not null
#  flabcost         :decimal(17, 5)   default(0.0), not null
#  flasteoc         :string(25)       default(""), not null
#  flct             :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fllotreqd        :boolean          default(FALSE), not null
#  fmatlcost        :decimal(17, 5)   default(0.0), not null
#  fmeasure2        :string(3)        default(""), not null
#  fnweight         :decimal(10, 3)   default(0.0), not null
#  fovhdcost        :decimal(17, 5)   default(0.0), not null
#  fprodcl          :string(2)        default(""), not null
#  freordqty        :decimal(15, 5)   default(0.0), not null
#  frevdt           :datetime         default(1900-01-01 00:00:00 UTC), not null
#  frolledup        :string(1)        default(""), not null
#  fsafety          :decimal(15, 5)   default(0.0), not null
#  fschecode        :string(6)        default(""), not null
#  fuprodtime       :decimal(9, 3)    default(0.0), not null
#  fyield           :decimal(8, 3)    default(0.0), not null
#  fabccode         :string(1)        default(""), not null
#  ftaxable         :boolean          default(FALSE), not null
#  fcusrchr1        :string(20)       default(""), not null
#  fcusrchr2        :string(40)       default(""), not null
#  fcusrchr3        :string(40)       default(""), not null
#  fnusrqty1        :decimal(15, 5)   default(0.0), not null
#  fnusrcur1        :decimal(17, 5)   default(0.0), not null
#  fdusrdate1       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fcdncfile        :string(80)       default(""), not null
#  fccadfile1       :string(250)      default(""), not null
#  fccadfile2       :string(250)      default(""), not null
#  fccadfile3       :string(250)      default(""), not null
#  fclotext         :string(1)        default(""), not null
#  flexpreqd        :boolean          default(FALSE), not null
#  fdlastpc         :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fschedtype       :string(1)        default(""), not null
#  fldctracke       :boolean          default(FALSE), not null
#  fddcrefdat       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fndctax          :decimal(17, 5)   default(0.0), not null
#  fndcduty         :decimal(17, 5)   default(0.0), not null
#  fndcfreigh       :decimal(17, 5)   default(0.0), not null
#  fndcmisc         :decimal(17, 5)   default(0.0), not null
#  fcratedisc       :string(1)        default(""), not null
#  flconstrnt       :boolean          default(FALSE), not null
#  flistaxabl       :boolean          default(FALSE), not null
#  fcjrdict         :string(10)       default(""), not null
#  flaplpart        :boolean          default(FALSE), not null
#  flfanpart        :boolean          default(FALSE), not null
#  fnfanaglvl       :integer          default(0), not null
#  fcplnclass       :string(1)        default(""), not null
#  fcclass          :string(12)       default(""), not null
#  fidims           :integer          default(0), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fcomment         :text             default(""), not null
#  fmusrmemo1       :text             default(""), not null
#  fstdmemo         :text             default(""), not null
#  fac              :string(20)       default("")
#  sfac             :string(20)       default("")
#  itcfixed         :decimal(17, 5)   default(0.0)
#  itcunit          :decimal(17, 5)   default(0.0)
#  fnPOnHand        :decimal(16, 5)   default(0.0), not null
#  fnLndToMfg       :decimal(16, 5)   default(0.0), not null
#  fcudrev          :string(3)        default(""), not null
#  fluseudrev       :boolean          default(FALSE), not null
#  fndbrmod         :integer          default(0), not null
#  fiPcsOnHd        :integer          default(0), not null
#  flSendSLX        :boolean          default(FALSE), not null
#  fcSLXProd        :string(12)       default(""), not null
#  flFSRtn          :boolean          default(FALSE), not null
#  fnlatefact       :decimal(4, 2)    default(0.0), not null
#  fnsobuf          :integer          default(0), not null
#  fnpurbuf         :integer          default(0), not null
#  flcnstrpur       :boolean          default(FALSE), not null
#  fdvenfence       :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flLatefact       :boolean          default(FALSE), not null
#  flSOBuf          :boolean          default(FALSE), not null
#  flPurBuf         :boolean          default(FALSE), not null
#  flHoldStoc       :boolean          default(FALSE), not null
#  fnHoldStoc       :decimal(4, 2)    default(0.0), not null
#  ManualPlan       :boolean          default(FALSE), not null
#  SchedDate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flocbfdef        :string(14)       default(""), not null
#  fbinbfdef        :string(14)       default(""), not null
#  DockTime         :integer          default(0), not null
#  fnifttime        :decimal(7, 1)    default(0.0), not null
#  flSynchOn        :boolean          default(FALSE), not null
#

require 'm2m/belongs_to_item_group'
require 'plutolib/active_hash_setter'

class M2m::Item < M2m::Base
  self.table_name = 'inmastx'
  include Plutolib::ActiveHashSetter
  # has_many :vendors, :class_name => 'M2m::InventoryVendor', :foreign_key => :fpartno, :primary_key => :fpartno
  # has_many :sales_order_items, :class_name => 'M2m::SalesOrderItem', :foreign_key => :fpartno, :primary_key => :fpartno
  # has_many :purchase_order_items, :class_name => 'M2m::PurchaseOrderItem', :foreign_key => :fpartno, :primary_key => :fpartno
  # has_many :quote_items, :class_name => 'M2m::QuoteItem', :foreign_key => :fpartno, :primary_key => :fpartno
  has_many :inventory_transactions, :class_name => 'M2m::InventoryTransaction', :foreign_key => :fpartno, :primary_key => :fpartno
  has_many :receiver_items, :class_name => 'M2m::ReceiverItem', :foreign_key => :fpartno, :primary_key => :fpartno
  has_many :shipper_items, :class_name => 'M2m::ShipperItem', :foreign_key => :fpartno, :primary_key => :fpartno
  has_many :revisions, :class_name => 'M2m::Item', :foreign_key => :fpartno, :primary_key => :fpartno
  include ::BelongsToItemGroup # self.group, self.group_name, etc
  
  def locations
    @locations ||= M2m::InventoryLocation.for_item(self)
  end
  def locations=(v)
    @locations = v
  end
  
  def vendors
    @vendors ||= M2m::InventoryVendor.for_item(self)
  end
  
  def part_number_revision
    @part_number_revision ||= [self.part_number, self.revision]
  end
  
  def part_number_and_revision
    @part_number_and_revision ||= AppConfig.use_item_revisions? ? "#{self.part_number} Rev #{self.revision}" : self.part_number
  end
  
  def to_s
    self.part_number_and_revision
  end

  # alias_attribute :total_cost, :fdisptcost
  alias_attribute :description, :fdescript
  alias_attribute :standard_cost, :fstdcost
  alias_attribute :rolled_standard_cost, :f2totcost
  alias_attribute :standard_material_cost, :fmatlcost
  alias_attribute :rolled_material_cost, :f2matlcost
  alias_attribute :standard_labor_cost, :flabcost
  alias_attribute :rolled_labor_cost, :f2labcost
  alias_attribute :standard_overhead_cost, :fovhdcost
  alias_attribute :rolled_overhead_cost, :f2ovhdcost
  alias_attribute :last_cost, :flastcost
  alias_attribute :average_cost, :favgcost
  alias_attribute :facility, :fac
  alias_attribute :source_facility, :sfac
  alias_attribute :product_class_key, :fprodcl
  alias_attribute :group_code_key, :fgroup
  alias_attribute :location, :flocate1
  alias_attribute :measure1, :fmeasure
  alias_attribute :measure2, :fmeasure2
  alias_attribute :abc_code, :fabccode
  alias_attribute :user_memo, :fmusrmemo1
  alias_attribute :standard_memo, :fstdmemo
  alias_attribute :price, :fprice
  alias_attribute :inspection_required, :finspect
  alias_attribute :drawing_number, :fdrawno
  
  def product_class
    M2m::ProductClass.product_class_key(self.product_class_key).first
  end
  
  # Uses same calculation that m2m uses.
  def quantity_available
    self.quantity_on_hand + self.quantity_on_order + self.quantity_in_inspection + self.quantity_in_process - self.quantity_committed - self.quantity_non_nettable
  end
  attr_accessor :item_quantities
  def call_item_quantity_proc(bit)
    if @item_quantities.nil?
      @item_quantities = { :OnHand => nil, :Committed => nil, :InProcess => nil, :Inspection => nil, :OnOrder => nil, :NonNet => nil }
      selects = []
      @item_quantities.keys.each do |key|
        selects.push "dbo.GetItem#{key}Quantity('#{self.fac.strip}', '#{self.part_number}', '#{self.revision}') as #{key}"
      end
      result = self.class.connection.select_one('select ' + selects.join(','))
      # Rails.logger.debug("***************** " + result.inspect)
      @item_quantities.keys.each do |key|
        @item_quantities[key] = result[key.to_s]
      end
    end
    @item_quantities[bit]
  end
  def quantity_on_hand
    # self.locations.to_a.sum(&:quantity_on_hand)
    call_item_quantity_proc(:OnHand)
  end
  def quantity_committed
    call_item_quantity_proc(:Committed)
  end
  def quantity_in_process
    call_item_quantity_proc(:InProcess)
  end
  def quantity_in_inspection
    call_item_quantity_proc(:Inspection)
  end
  def quantity_on_order
    call_item_quantity_proc(:OnOrder)
  end
  def quantity_non_nettable
    call_item_quantity_proc(:NonNet)
  end
  def total_cost
    self.send AppConfig.cost_method
  end

  def allow_standard_cost_rollup?
    self.fcostcode == 'R'
  end

  def allow_current_rolled_cost_rollup?
    self.f2costcode == 'R'
  end
  
  # def self.check
  #   errors = []
  #   self.find_each do |i|
  #     location_sum = i.locations.to_a.sum(&:quantity_on_hand)
  #     if (i.quantity_on_hand + i.quantity_in_inspection) != location_sum
  #       errors.push "#{i.part_number} #{i.quantity_on_hand} != #{location_sum} #{i.item_quantities.inspect}"
  #     end
  #   end
  #   puts "Found #{errors.size} errors: " + errors.join("\n")
  # end    

  alias_attribute :part_number, :fpartno
  def part_number
    @part_number ||= self.fpartno.strip
  end
  
  alias_attribute :revision, :frev
  def revision
    @revision ||= self.frev.strip
  end

  scope :part_number, -> (pn) { where(:fpartno => pn) }
  scope :revision, -> (r) { where(:frev => r) }
  scope :with_part_number, -> (pn) {
    where :fpartno => pn
  }
  scope :with_part_numbers, -> (part_numbers) {
    where [ 'inmastx.fpartno in (?)', part_numbers.uniq]
  }
  scope :by_rev_desc, -> { order('inmastx.frev').reverse_order }
  scope :by_part_number, -> { order('inmastx.fpartno') }
  scope :by_part_rev_desc, -> { order('inmastx.fpartno, inmastx.frev desc') }
  scope :company_or_vendor_part_number_like, -> (text) {
    text = M2m::Item.connection.quote('%' + (text.strip || '') + '%')
    joins <<-SQL
      INNER JOIN
      ( SELECT distinct [inmastx].identity_column FROM [inmastx] 
        LEFT JOIN [invend] ON invend.fpartno = inmastx.fpartno 
        WHERE (inmastx.fpartno like #{text} OR invend.fvpartno like #{text}) ) as tmp1
      on inmastx.identity_column = tmp1.identity_column
      SQL
  }
  scope :part_number_like, -> (text) {
    where [ 'inmastx.fpartno like ?', '%' + (text.strip || '') + '%' ]
  }
  scope :id_in, -> (id_array) {
    where [ 'inmastx.identity_column in (?)', id_array ]
  }
  
  def self.latest(part_number)
    self.with_part_number(part_number).by_rev_desc.first
  end
  
  def is_current?
    if @is_current.nil?
      @is_current = if ci = M2m::CurrentItem.for_part_number(self.part_number).first
        ci.is_item?(self)
      else
        false
      end
    end
    @is_current
  end

  def self.attach_items(objects, items=nil)
    items ||= M2m::Item.with_part_numbers(objects.map(&:part_number).uniq)
    items_hash = {}
    items.each { |item| items_hash[(item.part_number || '') + '-' + (item.revision || '')] = item }
    result = []
    objects.each do |o|
      okey = (o.part_number || '') + '-' + (o.revision || '')
      if okey.present? and (found = items_hash[okey])
        result.push o.item = found
      else
        # Explicitly set this to keep it from trying to lazy load.
        o.item = nil
      end
    end
    result
  end
  
  # def source
  #   M2m::ItemSource.find_by_key(self.fsource)
  # end
  active_hash_setter(M2m::ItemSource, :source, :fsource)
  
  def bom_parents
    M2m::BomItem.with_child_item(self).map(&:parent_item)
  end
  
  def same_item?(other_item)
    (other_item.part_number == self.part_number) and (!AppConfig.use_item_revisions? or (other_item.revision == self.revision))
  end
  
  # def customers
  #   M2m::SalesOrderItem.for_item(self).scoped(:include => {:sales_order => :customer}).map { |i| i.sales_order.customer }.uniq
  # end

  # class << self
  #   def item_cache
  #     @item_cache ||= {}
  #   end
  #   def parents_cache
  #     @parents_cache ||= {}
  #   end
  # end
  # 
  # def bom_parents
  #   return nil unless AppConfig.inventory_report_use_boms
  #   if @bom_parents.nil?
  #     unless parents = self.class.parents_cache[self.id]
  #       parents = M2m::BomItem.with_child_item(self).map(&:parent_item).compact
  #       self.class.parents_cache[self.id] = parents.map(&:id)
  #       parents.each do |item_parent|
  #         self.class.item_cache[item_parent.id] = item_parent
  #       end
  #     end
  #     @bom_parents = if parents.size > 0
  #       results = []
  #       to_load = []
  #       parents.each do |parent_id|
  #         if found = self.class.item_cache[parent_id]
  #           results.push found
  #         else
  #           to_load.push parent_id
  #         end
  #       end
  #       if to_load.size > 0
  #         M2m::Item.readonly.id_in(to_load).each do |parent|
  #           self.class.item_cache[parent.id] = parent
  #           results.push parent
  #         end
  #       end
  #       results
  #     else
  #       []
  #     end
  #   end
  #   @bom_parents
  # end
end

