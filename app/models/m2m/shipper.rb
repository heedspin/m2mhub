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
  alias_attribute :bill_of_lading, :fbl_lading
  alias_attribute :ship_via, :fshipvia

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
# == Schema Information
#
# Table name: shmast
#
#  fbl_lading       :string(20)      not null
#  fcjobno          :string(10)      not null
#  fcnumber         :string(6)       not null
#  fcollect         :string(3)       not null
#  fconfirm         :string(1)       not null
#  fcpono           :string(6)       not null
#  fcpro_id         :string(7)       not null
#  fcsono           :string(6)       not null
#  fcsorev          :string(2)       not null
#  fcvendno         :string(6)       not null
#  fenter           :string(3)       not null
#  ffob             :string(20)      not null
#  ffrtamt          :decimal(17, 5)  not null
#  ffrtinvcd        :boolean         not null
#  flisinv          :boolean         not null
#  fno_boxes        :integer         not null
#  fshipdate        :datetime        not null
#  fshipno          :string(6)       not null, primary key
#  fshipvia         :string(20)      not null
#  fshipwght        :decimal(12, 4)  not null
#  fshptoaddr       :string(4)       not null
#  ftype            :string(2)       not null
#  start            :datetime        not null
#  flpickprin       :boolean         not null
#  flshipprin       :boolean         not null
#  fcfname          :string(15)      not null
#  fclname          :string(20)      not null
#  fccounty         :string(20)      not null
#  fccompany        :string(35)      default(" "), not null
#  fccity           :string(20)      not null
#  fccountry        :string(25)      not null
#  fcfax            :string(20)      not null
#  fcphone          :string(20)      not null
#  fcstate          :string(20)      not null
#  fczip            :string(10)      not null
#  fporev           :string(2)       not null
#  fcbcompany       :string(35)      default(" "), not null
#  flpremcv         :boolean         not null
#  fcso_inum        :string(3)       not null
#  fcsono_rel       :string(3)       not null
#  timestamp_column :binary
#  identity_column  :integer(4)      not null
#  fmreferenc       :text            default(" "), not null
#  fmstreet         :text            default(" "), not null
#  fmtrckno         :text            default(" "), not null
#  fshipmemo        :text            default(" "), not null
#  upsdate          :datetime        not null
#  upsaddr2         :text            default(""), not null
#  upsaddr3         :text            default(""), not null
#

