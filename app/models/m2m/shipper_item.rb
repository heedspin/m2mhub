# == Schema Information
#
# Table name: shitem
#
#  fitemno          :char(6)          default("      "), not null
#  fitemtype        :char(1)          default(" "), not null
#  fpartno          :char(25)         default("                         "), not null
#  frev             :char(3)          default("   "), not null
#  fenumber         :char(6)          default("      "), not null
#  finvqty          :decimal(15, 5)   default(0.0), not null
#  fmeasure         :char(3)          default("   "), not null
#  forderqty        :decimal(15, 5)   default(0.0), not null
#  fcpokey          :varchar(16)      default(""), not null
#  fshipno          :varchar(10)      default(""), not null
#  fshipqty         :decimal(15, 5)   default(0.0), not null
#  fsokey           :varchar(16)      default(""), not null
#  fcstatus         :char(1)          default(" "), not null
#  fcmiscstat       :char(1)          default(" "), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmdescript       :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  sfac             :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  IdoNo            :char(10)         default("          "), not null
#  QtyRecvd         :decimal(15, 5)   default(0.0), not null
#  fcustpart        :char(25)         default("                         "), not null
#  flInvcPoss       :boolean          default(FALSE), not null
#  IsoNo            :varchar(10)      default(""), not null
#  FPONO            :varchar(10)      default(""), not null
#  FPOITEMNO        :varchar(3)       default(""), not null
#  FPORELSNO        :varchar(3)       default(""), not null
#  FSONO            :varchar(10)      default(""), not null
#  FINUMBER         :varchar(3)       default(""), not null
#  FRELEASE         :varchar(3)       default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::ShipperItem < M2m::Base
  default_scope -> { order('shitem.fenumber') }
  self.table_name = 'shitem'

  belongs_to :shipper, :class_name => 'M2m::Shipper', :foreign_key => :fshipno
  belongs_to_item :fpartno, :frev
  
  alias_attribute :quantity, :fshipqty
  alias_attribute :quantity_shipped, :fshipqty
  alias_attribute :quantity_ordered, :forderqty
  alias_attribute :sales_order_number, :fsono
  alias_attribute :shipper_number, :fshipno
  alias_attribute :sales_order_item_number, :fenumber

  attr_accessor :sales_order_release
  def sales_order_release
    @sales_order_release ||= M2m::SalesOrderRelease.for_shipper_items(self).first
  end

  def self.attach_sales_orders(shippers)
    items = shippers.map(&:items).flatten
    releases = M2m::SalesOrderRelease.for_shipper_items(items).includes(:sales_order)
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
  
  scope :for_sales_order, -> (sales_order) {
    joins('inner join sorels on sorels.fsono = SUBSTRING(shitem.fsokey,1,6) AND sorels.finumber = SUBSTRING(shitem.fsokey,7,3) AND sorels.frelease = SUBSTRING(shitem.fsokey,10,3)').
    where([ 'sorels.fsono = ?', sales_order.id ])
  }
  scope :for_release, -> (release) {
    joins('inner join sorels on sorels.fsono = SUBSTRING(shitem.fsokey,1,6) AND sorels.finumber = SUBSTRING(shitem.fsokey,7,3) AND sorels.frelease = SUBSTRING(shitem.fsokey,10,3)').
    where([ 'sorels.fsono = ? and sorels.frelease = ?', release.fsono, release.frelease ])
    # 'select shitem.* from shitem where #{fsono} = SUBSTRING(shitem.fsokey,1,6) AND #{finumber} = SUBSTRING(shitem.fsokey,7,3) AND #{frelease} = SUBSTRING(shitem.fsokey,10,3)'    
  }
  scope :by_ship_date_desc, -> { joins(:shipper).order('shmast.fshipdate desc, shitem.fitemno') } 
  scope :shipped_after, -> (date) {
    joins(:shipper).
    where([ 'shmast.fshipdate >= ?', date ])
  }
end

