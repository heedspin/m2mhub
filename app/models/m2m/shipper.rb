# == Schema Information
#
# Table name: shmast
#
#  fbl_lading       :string(20)       default(""), not null
#  fcjobno          :string(10)       default(""), not null
#  fcnumber         :string(6)        default(""), not null
#  fcollect         :string(3)        default(""), not null
#  fconfirm         :string(1)        default(""), not null
#  fcpono           :string(6)        default(""), not null
#  fcpro_id         :string(7)        default(""), not null
#  fcsono           :string(6)        default(""), not null
#  fcsorev          :string(2)        default(""), not null
#  fcvendno         :string(6)        default(""), not null
#  fenter           :string(3)        default(""), not null
#  ffob             :string(20)       default(""), not null
#  ffrtamt          :decimal(17, 5)   default(0.0), not null
#  ffrtinvcd        :boolean          default(FALSE), not null
#  flisinv          :boolean          default(FALSE), not null
#  fno_boxes        :integer          default(0), not null
#  fshipdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fshipno          :string(6)        default(""), not null, primary key
#  fshipvia         :string(20)       default(""), not null
#  fshipwght        :decimal(12, 4)   default(0.0), not null
#  fshptoaddr       :string(4)        default(""), not null
#  ftype            :string(2)        default(""), not null
#  start            :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  flpickprin       :boolean          default(FALSE), not null
#  flshipprin       :boolean          default(FALSE), not null
#  fcfname          :string(15)       default(""), not null
#  fclname          :string(20)       default(""), not null
#  fccounty         :string(20)       default(""), not null
#  fccompany        :string(35)       default(""), not null
#  fccity           :string(20)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  fcfax            :string(20)       default(""), not null
#  fcphone          :string(20)       default(""), not null
#  fcstate          :string(20)       default(""), not null
#  fczip            :string(10)       default(""), not null
#  fporev           :string(2)        default(""), not null
#  fcbcompany       :string(35)       default(""), not null
#  flpremcv         :boolean          default(FALSE), not null
#  fcso_inum        :string(3)        default(""), not null
#  fcsono_rel       :string(3)        default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null
#  fmreferenc       :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fmtrckno         :text             default(""), not null
#  fshipmemo        :text             default(""), not null
#  upsdate          :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  upsaddr2         :text             default(""), not null
#  upsaddr3         :text             default(""), not null
#

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
  
  scope :with_ship_date, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'shmast.fshipdate = ?', date.to_s(:database) ],
    }
  }  
  scope :for_next_day, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'shmast.fshipdate > ?', date.to_s(:database) ],
      :order => :fshipdate
    }
  }
  scope :for_previous_day, lambda { |date|
    date = date.is_a?(String) ? Date.parse(date) : date
    {
      :conditions => [ 'shmast.fshipdate < ?', date.to_s(:database) ],
      :order => 'shmast.fshipdate desc'
    }
  }
  scope :by_shipper_number_desc, :order => 'shmast.fshipno desc'
  scope :next_shipper, lambda { |shipper| 
    {
      :conditions => ['fshipno > ?', shipper.fsono], 
      :order => 'fshipno',
      :limit => 1
    }
  }
  scope :previous_shipper, lambda { |shipper| 
    {
      :conditions => ['fshipno < ?', shipper.fsono], 
      :order => 'fshipno desc',
      :limit => 1
    }
  }
  scope :for_item, lambda { |item|
    {
      # Using include vs joins eliminates duplicates.
      :include => :items,
      :conditions => { :shitem => { :fpartno => item.fpartno, :frev => item.frev } }
    }
  }
  scope :by_ship_date_desc, :order => 'shmast.fshipdate desc'
  
  def self.monthly_quantity_shipped(start_date, end_date)
    results = connection.select_rows <<-SQL
    select cast( cast(datepart(year, shmast.fshipdate) as varchar) + '-' +
                 cast(datepart(month, shmast.fshipdate) as varchar) + '-01' as date) as month,
           sum(shitem.fshipqty) as quantity_shipped
    from shmast
    left join shitem on shitem.fshipno = shmast.fshipno
    where shmast.fshipdate >= '#{start_date.to_s(:database)}'
      and shmast.fshipdate < '#{end_date.to_s(:database)}'
    group by datepart(month, shmast.fshipdate), datepart(year,shmast.fshipdate)
    order by month
    SQL
    months = {}
    results.each do |month, quantity_shipped|
      months[Date.parse(month)] = quantity_shipped
    end
    months
  end
  
end

