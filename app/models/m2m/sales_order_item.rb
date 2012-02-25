class M2m::SalesOrderItem < M2m::Base
  default_scope :order => 'soitem.fenumber'
  set_table_name 'soitem'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
  has_many :releases, :class_name => 'M2m::SalesOrderRelease', :foreign_key => :fsono, :primary_key => :fsono, :conditions => 'sorels.fenumber = \'#{fenumber}\''
  belongs_to_item :fpartno, :fpartrev

  alias_attribute :quantity, :fquantity
  alias_attribute :unit_price, :fprice
  alias_attribute :customer_part_number, :fcustpart
  alias_attribute :due_date, :fduedate
  alias_attribute :internal_number, :finumber
  alias_attribute :external_number, :fenumber
  
  alias_attribute :multiple_releases, :fmultiple
  
  scope :status_open,      :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.open.name} }
  scope :status_closed,    :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.closed.name} }
  scope :status_cancelled, :joins => :sales_order, :conditions => { :somast => {:fstatus => M2m::Status.cancelled.name} }
  
  scope :part_number_like, lambda { |text| 
    text = '%' + (text || '') + '%'
    {
      :conditions => [ 'soitem.fcustpart like ? or soitem.fpartno like ?', text, text]
    }
  }
  
  scope :order_number_like, lambda { |text|
    text = '%' + (text || '') + '%'
    {
      :joins => :sales_order,
      :conditions => [ 'somast.fcustpono like ? OR somast.fsono like ?', text, text]
    }
  }
  
  scope :for_item, lambda { |item|
    {
      :conditions => { :fpartno => item.part_number, :fpartrev => item.revision }
    }
  }
  
  scope :for_releases, lambda { |sales_order_releases|
    {
      :conditions => ['soitem.fsono in (?)', sales_order_releases.map(&:sales_order_number).uniq]
    }
  }
  
  scope :for_release, lambda { |release|
    {
      :conditions => { :fsono => release.fsono, :fenumber => release.fenumber }
    }
  }
  
  def self.attach_to_releases(sales_order_releases)
    if sales_order_releases.size > 0
      sales_order_items = M2m::SalesOrderItem.for_releases(sales_order_releases)
      items = M2m::Item.with_part_numbers(sales_order_items.map(&:part_number))
      sales_order_releases.each do |r|
        if i = sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
          r.item = i
          i.sales_order = r.sales_order
          i.item = items.detect { |c| (c.part_number == i.part_number) && (c.revision == i.revision) }
        end
      end
    end
  end

  def self.attach_to_releases_with_item(sales_order_releases, item)
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

  def self.attach_to_releases_for_backlog(sales_order_releases, sales_order_items)
    if (sales_order_releases.size > 0) and (sales_order_items.size > 0)
      sales_order_releases.each do |r|
        r.item = sales_order_items.detect { |i| (i.fsono == r.fsono) && (i.fenumber == r.fenumber) }
      end
    end
  end
  
end



# == Schema Information
#
# Table name: soitem
#
#  finumber         :string(3)       default(""), not null
#  fpartno          :string(25)      default(""), not null
#  fpartrev         :string(3)       default(""), not null
#  fsono            :string(6)       default(""), not null
#  fclotext         :string(1)       default(""), not null
#  fllotreqd        :boolean         default(FALSE), not null
#  fautocreat       :boolean         default(FALSE), not null
#  fcas_bom         :boolean         default(FALSE), not null
#  fcas_rtg         :boolean         default(FALSE), not null
#  fcommpct         :decimal(8, 2)   default(0.0), not null
#  fcustpart        :string(25)      default(""), not null
#  fcustptrev       :string(3)       default(""), not null
#  fdet_bom         :boolean         default(FALSE), not null
#  fdet_rtg         :boolean         default(FALSE), not null
#  fduedate         :datetime        default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fenumber         :string(3)       default(""), not null
#  ffixact          :decimal(17, 5)  default(0.0), not null
#  fgroup           :string(6)       default(""), not null
#  flabact          :decimal(17, 5)  default(0.0), not null
#  fmatlact         :decimal(17, 5)  default(0.0), not null
#  fmeasure         :string(3)       default(""), not null
#  fmultiple        :boolean         default(FALSE), not null
#  fnextinum        :integer(4)      default(0), not null
#  fnextrel         :integer(4)      default(0), not null
#  fnunder          :decimal(12, 5)  default(0.0), not null
#  fnover           :decimal(12, 5)  default(0.0), not null
#  fordertype       :string(3)       default(""), not null
#  fothract         :decimal(17, 5)  default(0.0), not null
#  fovhdact         :decimal(17, 5)  default(0.0), not null
#  fprice           :boolean         default(FALSE), not null
#  fprintmemo       :boolean         default(FALSE), not null
#  fprodcl          :string(2)       default(""), not null
#  fquantity        :decimal(17, 5)  default(0.0), not null
#  fcfromtype       :string(6)       default(""), not null
#  fcfromno         :string(25)      default("")
#  fcfromitem       :string(3)       default(""), not null
#  fquoteqty        :decimal(15, 5)  default(0.0), not null
#  frtgsetupa       :decimal(17, 5)  default(0.0), not null
#  fschecode        :string(6)       default(""), not null
#  fshipitem        :boolean         default(FALSE), not null
#  fsoldby          :string(3)       default(""), not null
#  fsource          :string(1)       default(""), not null
#  fstandpart       :boolean         default(FALSE), not null
#  fsubact          :decimal(17, 5)  default(0.0), not null
#  fsummary         :boolean         default(FALSE), not null
#  ftaxcode         :string(3)       default(""), not null
#  ftaxrate         :decimal(7, 3)   default(0.0), not null
#  ftoolact         :decimal(17, 5)  default(0.0), not null
#  ftnumoper        :integer(4)      default(0), not null
#  ftotnonpr        :integer(4)      default(0), not null
#  ftotptime        :decimal(15, 5)  default(0.0), not null
#  ftotstime        :decimal(15, 5)  default(0.0), not null
#  fulabcost1       :decimal(17, 5)  default(0.0), not null
#  fviewprice       :boolean         default(FALSE), not null
#  fcprodid         :string(6)       default(""), not null
#  fschedtype       :string(1)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fdesc            :text            default(""), not null
#  fdescmemo        :text            default(""), not null
#  fac              :string(20)      default(""), not null
#  sfac             :string(20)      default(""), not null
#  ITCCOST          :decimal(17, 5)  default(0.0), not null
#  fcudrev          :string(3)       default(""), not null
#  fndbrmod         :integer(4)      default(0), not null
#  FcAltUM          :string(3)       default(""), not null
#  FnAltQty         :decimal(17, 5)  default(0.0), not null
#  fnlatefact       :decimal(4, 2)   default(0.0), not null
#  fnsobuf          :integer(4)      default(0), not null
#  ManualPlan       :boolean         default(FALSE), not null
#  ContractNu       :string(10)      default(""), not null
#  Flrfqreqd        :boolean         default(FALSE), not null
#  Fcostfrom        :string(9)       default(""), not null
#

