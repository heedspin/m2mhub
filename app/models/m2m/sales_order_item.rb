class M2m::SalesOrderItem < M2m::Base
  default_scope :order => 'soitem.fenumber'
  set_table_name 'soitem'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fpartno, :fpartrev]
  has_many :releases, :class_name => 'M2m::SalesOrderRelease', :foreign_key => :fsono, :primary_key => :fsono, :conditions => 'sorels.fenumber = \'#{fenumber}\''

  alias_attribute :quantity, :fquantity
  alias_attribute :unit_price, :fprice
  alias_attribute :customer_part_number, :fcustpart
  alias_attribute :due_date, :fduedate
  
  alias_attribute :multiple_releases, :fmultiple

  named_scope :open,      :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.open.name} }
  named_scope :closed,    :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.closed.name} }
  named_scope :cancelled, :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.cancelled.name} }
  
  named_scope :part_number_like, lambda { |text| 
    text = '%' + (text || '') + '%'
    {
      :conditions => [ 'soitem.fcustpart like ? or soitem.fpartno like ?', text, text]
    }
  }
  
  named_scope :order_number_like, lambda { |text|
    text = '%' + (text || '') + '%'
    {
      :joins => :sales_order,
      :conditions => [ 'somast.fcustpono like ? OR somast.fsono like ?', text, text]
    }
  }
  
  named_scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision }
    }
  }
  
  named_scope :for_releases, lambda { |sales_order_releases|
    {
      :conditions => ['soitem.fsono in (?)', sales_order_releases.map(&:sales_order_number).uniq]
    }
  }
  
  def self.attach_to_releases(sales_order_releases, item)
    if sales_order_releases.size > 0
      sales_order_items = M2m::SalesOrderItem.for_releases(sales_order_releases).all(:include => :sales_order)    
      sales_order_releases.each do |r|
        if i = sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
          r.item = i
          r.sales_order = i.sales_order
          i.item = item
        end
      end
    end
  end

end

# == Schema Information
#
# Table name: soitem
#
#  finumber         :string(3)       not null
#  fpartno          :string(25)      not null
#  fpartrev         :string(3)       not null
#  fsono            :string(6)       not null
#  fclotext         :string(1)       not null
#  fllotreqd        :boolean         not null
#  fautocreat       :boolean         not null
#  fcas_bom         :boolean         not null
#  fcas_rtg         :boolean         not null
#  fcommpct         :decimal(8, 2)   not null
#  fcustpart        :string(25)      not null
#  fcustptrev       :string(3)       not null
#  fdet_bom         :boolean         not null
#  fdet_rtg         :boolean         not null
#  fduedate         :datetime        not null
#  fenumber         :string(3)       not null
#  ffixact          :decimal(17, 5)  not null
#  fgroup           :string(6)       not null
#  flabact          :decimal(17, 5)  not null
#  fmatlact         :decimal(17, 5)  not null
#  fmeasure         :string(3)       not null
#  fmultiple        :boolean         not null
#  fnextinum        :integer         not null
#  fnextrel         :integer         not null
#  fnunder          :decimal(12, 5)  not null
#  fnover           :decimal(12, 5)  not null
#  fordertype       :string(3)       not null
#  fothract         :decimal(17, 5)  not null
#  fovhdact         :decimal(17, 5)  not null
#  fprice           :boolean         not null
#  fprintmemo       :boolean         not null
#  fprodcl          :string(2)       not null
#  fquantity        :decimal(17, 5)  not null
#  fcfromtype       :string(6)       not null
#  fcfromno         :string(6)       not null
#  fcfromitem       :string(3)       not null
#  fquoteqty        :decimal(15, 5)  not null
#  frtgsetupa       :decimal(17, 5)  not null
#  fschecode        :string(6)       not null
#  fshipitem        :boolean         not null
#  fsoldby          :string(3)       not null
#  fsource          :string(1)       not null
#  fstandpart       :boolean         not null
#  fsubact          :decimal(17, 5)  not null
#  fsummary         :boolean         not null
#  ftaxcode         :string(3)       not null
#  ftaxrate         :decimal(7, 3)   not null
#  ftoolact         :decimal(17, 5)  not null
#  ftnumoper        :integer         not null
#  ftotnonpr        :integer         not null
#  ftotptime        :decimal(15, 5)  not null
#  ftotstime        :decimal(15, 5)  not null
#  fulabcost1       :decimal(7, 2)   not null
#  fviewprice       :boolean         not null
#  fcprodid         :string(6)       not null
#  fschedtype       :string(1)       not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdesc            :text            default(" "), not null
#  fdescmemo        :text            default(" "), not null
#  fac              :string(20)      not null
#  sfac             :string(20)      not null
#  ITCCOST          :decimal(17, 5)  not null
#  fcudrev          :string(3)       default(" "), not null
#  fndbrmod         :integer         default(0), not null
#  FcAltUM          :string(3)       default(""), not null
#  FnAltQty         :decimal(17, 5)  default(0.0), not null
#  fnlatefact       :decimal(4, 2)   not null
#  fnsobuf          :integer         not null
#  ManualPlan       :boolean         not null
#

