class AddInventoryReportNextDates < ActiveRecord::Migration
  def up
    add_column :inventory_report_items, :next_ship_date, :datetime
    add_column :inventory_report_items, :next_receipt_date, :datetime
  end

  def down
  end
end