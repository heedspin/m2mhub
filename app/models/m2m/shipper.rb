class M2m::Shipper < M2m::Base
  set_table_name 'shmast'
  set_primary_key 'fshipno'
  
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fcsono, :primary_key => :fcsono
  has_many :items, :class_name => 'M2m::ShipperItem', :foreign_key => :fshipno
  
  alias_attribute :sales_order_number, :fcsono
  alias_attribute :customer_po, :fcpono
  alias_attribute :customer_number, :fcnumber
  alias_attribute :confirmation_date, :start
  alias_attribute :ship_date, :fshipdate

  def customer_name
    M2m::Customer.customer_name(self.fccompany)
  end
  
  def status
    self.fconfirm ? 'Shipped' : 'Not Shipped'
  end
  
  named_scope :with_ship_date, lambda { |ship_date|
    {
      :conditions => { :fshipdate => ship_date }
    }
  }
  
  named_scope :for_next_day, lambda { |ship_date|
    {
      :conditions => [ 'shmast.fshipdate > ?', ship_date ],
      :order => :fshipdate
    }
  }
  
  named_scope :for_previous_day, lambda { |ship_date|
    {
      :conditions => [ 'shmast.fshipdate < ?', ship_date ],
      :order => 'shmast.fshipdate desc'
    }
  }
  
  named_scope :by_shipper_number_desc, :order => 'fshipno desc'

  named_scope :next_shipper, lambda { |shipper| 
    {
      :conditions => ['fshipno > ?', shipper.fsono], 
      :order => 'fshipno',
      :limit => 1
    }
  }

  named_scope :previous_shipper, lambda { |shipper| 
    {
      :conditions => ['fshipno < ?', shipper.fsono], 
      :order => 'fshipno desc',
      :limit => 1
    }
  }
  
  named_scope :for_item, lambda { |item|
    {
      :joins => :items,
      :conditions => [ 'shitem.fpartno = ?', item.fpartno ]
    }
  }
  
end