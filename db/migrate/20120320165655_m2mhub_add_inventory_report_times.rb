class M2mhubAddInventoryReportTimes < ActiveRecord::Migration
  def up
    add_column :inventory_report_items, :last_receipt_date, :datetime
    add_column :inventory_report_items, :last_ship_date, :datetime
  end

  def down
  end
end