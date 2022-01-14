# == Schema Information
#
# Table name: shmast
#
#  fbl_lading       :char(20)         default("                    "), not null
#  fcjobno          :varchar(20)      default(""), not null
#  fcnumber         :char(6)          default("      "), not null
#  fcollect         :char(3)          default("   "), not null
#  fconfirm         :char(1)          default(" "), not null
#  fcpono           :varchar(10)      default(""), not null
#  fcpro_id         :char(7)          default("       "), not null
#  fcsono           :varchar(10)      default(""), not null
#  fcso_inum        :char(3)          default("   "), not null
#  fcsono_rel       :char(3)          default("   "), not null
#  fcsorev          :char(2)          default("  "), not null
#  fcvendno         :char(6)          default("      "), not null
#  fenter           :char(3)          default("   "), not null
#  ffob             :char(20)         default("                    "), not null
#  ffrtinvcd        :boolean          default(FALSE), not null
#  flisinv          :boolean          default(FALSE), not null
#  fshipdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fshipno          :varchar(10)      default(""), not null, primary key
#  fshipvia         :char(20)         default("                    "), not null
#  fshptoaddr       :varchar(6)       default(""), not null
#  ftype            :char(2)          default("  "), not null
#  start            :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flpickprin       :boolean          default(FALSE), not null
#  flshipprin       :boolean          default(FALSE), not null
#  fcfname          :char(15)         default("               "), not null
#  fclname          :char(20)         default("                    "), not null
#  fccounty         :char(20)         default("                    "), not null
#  fccompany        :varchar(35)      default(""), not null
#  fccity           :char(20)         default("                    "), not null
#  fccountry        :char(25)         default("                         "), not null
#  fcfax            :char(20)         default("                    "), not null
#  fcphone          :char(20)         default("                    "), not null
#  fcstate          :char(20)         default("                    "), not null
#  fczip            :char(10)         default("          "), not null
#  fporev           :char(2)          default("  "), not null
#  fcbcompany       :varchar(35)      default(""), not null
#  flpremcv         :boolean          default(FALSE), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null
#  fmreferenc       :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fshipmemo        :varchar_max(2147 default(""), not null
#  upsaddr2         :varchar_max(2147 default(""), not null
#  upsaddr3         :varchar_max(2147 default(""), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::Shipper < M2m::Base
  self.table_name = 'shmast'
  self.primary_key = 'fshipno'
  
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
  
  scope :with_ship_date, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where([ 'shmast.fshipdate = ?', date.to_s(:database) ])
  }  
  scope :for_next_day, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where([ 'shmast.fshipdate > ?', date.to_s(:database) ]).
    order(:fshipdate)
  }
  scope :for_previous_day, -> (date) {
    date = date.is_a?(String) ? DateParser.parse(date) : date
    where([ 'shmast.fshipdate < ?', date.to_s(:database) ]).
    order('shmast.fshipdate desc')
  }
  scope :by_shipper_number_desc, -> { order('shmast.fshipno desc') }
  scope :next_shipper, -> (shipper) {
    where(['fshipno > ?', shipper.fsono]).
    order('fshipno').
    limit(1)
  }
  scope :previous_shipper, -> (shipper) {
    where(['fshipno < ?', shipper.fsono]).
    order('fshipno desc').limit(1)
  }
  scope :for_item, -> (item) {
    includes(:items).
    where(:shitem => { :fpartno => item.fpartno, :frev => item.frev })
  }
  scope :for_item_with_duplicates, -> (item) {
    # Using include vs joins eliminates duplicates.
    joins(:items).
    where(:shitem => { :fpartno => item.fpartno, :frev => item.frev })
  }
  scope :by_ship_date_desc, -> { order('shmast.fshipdate desc') }
  
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
      month = DateParser.parse(month) unless month.is_a?(Date)
      months[month] = quantity_shipped
    end
    months
  end
  
end

