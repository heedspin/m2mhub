class M2m::ShipperItem < M2m::Base
  default_scope :order => 'shitem.fenumber'
  set_table_name 'shitem'

  belongs_to :shipper, :class_name => 'M2m::Shipper', :foreign_key => :fshipno
  belongs_to :item, :class_name => 'M2m::Item', :foreign_key => :fpartno, :primary_key => :fpartno  
  # belongs_to :item, :class_name => 'M2m::Item', :foreign_key => [:fpartno, :fpartrev]
  
  alias_attribute :quantity_shipped, :fshipqty
  alias_attribute :quantity_ordered, :forderqty
  alias_attribute :revision, :frev

  attr_accessor :sales_order_release
  def sales_order_release
    @sales_order_release ||= M2m::SalesOrderRelease.for_shipper_items(self).first
  end

  def self.attach_sales_orders(shippers)
    items = shippers.map(&:items).flatten
    releases = M2m::SalesOrderRelease.for_shipper_items(items).all(:include => :sales_order)
    releases.each do |release|
      if item = items.detect { |i| i.for_sales_order_release?(release) }
        item.sales_order_release = release
      end
    end
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
    
  def for_sales_order_release?(release)
    (self.sales_order_number == release.sales_order_number) && (self.sales_order_release_id == release.sales_order_release_id) && (self.sales_order_release_number == release.sales_order_release_number)
  end
  
  named_scope :for_sales_order, lambda { |sales_order|
    {
      :joins => 'inner join sorels on sorels.fsono = SUBSTRING(shitem.fsokey,1,6) AND sorels.finumber = SUBSTRING(shitem.fsokey,7,3) AND sorels.frelease = SUBSTRING(shitem.fsokey,10,3)',
      :conditions => [ 'sorels.fsono = ?', sales_order.id ]
    }
  }  
  
end

# == Schema Information
#
# Table name: shitem
#
#  fitemno          :string(6)       not null
#  fitemtype        :string(1)       not null
#  fpartno          :string(25)      not null
#  frev             :string(3)       not null
#  fenumber         :string(6)       not null
#  finvqty          :decimal(15, 5)  not null
#  fmeasure         :string(3)       not null
#  forderqty        :decimal(15, 5)  not null
#  fcpokey          :string(12)      not null
#  fshipno          :string(6)       not null
#  fshipqty         :decimal(15, 5)  not null
#  fsokey           :string(12)      not null
#  fcstatus         :string(1)       not null
#  fcmiscstat       :string(1)       not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null, primary key
#  fmdescript       :text            default(" "), not null
#  fac              :string(20)      not null
#  sfac             :string(20)      not null
#  fcudrev          :string(3)       default(" "), not null
#  IdoNo            :string(10)      default(""), not null
#  QtyRecvd         :decimal(15, 5)  default(0.0), not null
#  fcustpart        :string(25)      not null
#

