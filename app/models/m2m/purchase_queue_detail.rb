# == Schema Information
#
# Table name: pqdetl
#
#  fcavendno        :char(6)          default("      "), not null
#  fccomment        :char(20)         default("                    "), not null
#  fcdocno          :char(25)         default("                         "), not null
#  fcjono           :varchar(20)      default(""), not null
#  fclineno         :char(3)          default("   "), not null
#  fcpartno         :char(25)         default("                         "), not null
#  fcpartrev        :char(3)          default("   "), not null
#  fcpoitm          :char(3)          default("   "), not null
#  fcpono           :varchar(10)      default(""), not null
#  fcporls          :char(3)          default("   "), not null
#  fcrecsrc         :char(1)          default(" "), not null
#  fcsoitm          :char(3)          default("   "), not null
#  fcsono           :varchar(10)      default(""), not null
#  fcsorls          :char(3)          default("   "), not null
#  fcsource         :char(5)          default("     "), not null
#  fcstatus         :char(10)         default("          "), not null
#  fcsupdem         :char(1)          default(" "), not null
#  fctype           :char(2)          default("  "), not null
#  fcwcid           :char(7)          default("       "), not null
#  fdactdate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  fdduedate        :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flactreqd        :boolean          default(FALSE), not null
#  flactsel         :boolean          default(FALSE), not null
#  flvendsel        :boolean          default(FALSE), not null
#  fnextcost        :decimal(17, 5)   default(0.0), not null
#  fnjoopno         :integer          default(0), not null
#  fnordqty         :decimal(17, 5)   default(0.0), not null
#  fnqtyavail       :decimal(17, 5)   default(0.0), not null
#  fntxnqty         :decimal(17, 5)   default(0.0), not null
#  fnunitcost       :decimal(17, 5)   default(0.0), not null
#  fnnetavail       :decimal(17, 5)   default(0.0), not null
#  fcjodbomno       :char(4)          default("    "), not null
#  identity_column  :integer          not null, primary key
#  timestamp_column :ss_timestamp
#  fac              :char(20)         default("                    "), not null
#  fcudrev          :char(3)          default("   "), not null
#  CreatedDate      :datetime
#  ModifiedDate     :datetime
#

class M2m::PurchaseQueueDetail < M2m::Base
  self.table_name = 'pqdetl'
  belongs_to_item :fcpartno, :fcpartrev
  alias_attribute :comment, :fccomment
  alias_attribute :detail_type, :fctype
  alias_attribute :status, :fcstatus
  alias_attribute :source, :fcsource
  alias_attribute :sales_order_number, :fcsono
  alias_attribute :sales_order_item, :fcsoitm
  alias_attribute :purchase_order_number, :fcpono
  alias_attribute :purchase_order_item, :fcpoitm
  alias_attribute :transaction_quantity, :fntxnqty
  alias_attribute :order_quantity, :fnordqty
  alias_attribute :quantity_available, :fnqtyavail
  alias_attribute :net_quantity_available, :fnnetavail
  alias_date_attribute :due_date, :fdduedate
  alias_date_attribute :actual_date, :fdactdate
  alias_attribute :document_number, :fcdocno
  alias_attribute :line_number, :fclineno
  alias_attribute :supply_or_demand_key, :fcsupdem
  
  scope :for_summary, -> (summary) {
    where :fcpartno => summary.part_number, :fcpartrev => summary.revision
  }

  def sort_tuple
    [self.due_date, self.supply? ? 0 : 1]
  end
  def supply?
    self.supply_or_demand_key == 'S'
  end
  def demand?
    self.supply_or_demand_key == 'D'
  end
  def supply_quantity
    self.supply? ? self.transaction_quantity : 0
  end
  def demand_quantity
    self.demand? ? self.transaction_quantity : 0
  end
end
