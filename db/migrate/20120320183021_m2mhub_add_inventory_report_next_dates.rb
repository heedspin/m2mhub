class M2mhubAddInventoryReportNextDates < ActiveRecord::Migration
  def up
    add_column :inventory_report_items, :next_ship_date, :datetime
    add_column :inventory_report_items, :next_receipt_date, :datetime
    add_column :inventory_reports, :total_on_hand_locations, :integer
    add_column :inventory_reports, :total_run_time_seconds, :integer
    add_column :inventory_reports, :total_sales_order_releases, :integer
    add_column :inventory_reports, :total_purchase_order_items, :integer
  end

  def down
  end
end