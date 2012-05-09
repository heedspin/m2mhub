class M2mhubAddInventoryReportMovements < ActiveRecord::Migration
  def up
    add_column :inventory_reports, :movement_data, :text
    add_column :inventory_report_customers, :movement_data, :text
    add_column :inventory_report_items, :movement_data, :text
    remove_column :inventory_reports, :total_sales_order_releases
    remove_column :inventory_reports, :total_purchase_order_items
    add_column :inventory_reports, :report_date, :date
  end

  def down
  end
end