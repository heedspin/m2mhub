class M2mhubAddInventoryReportItemData < ActiveRecord::Migration
  def up
    add_column :inventory_report_items, :item_group_code_key, :string
    rename_column :inventory_report_items, :last_receipt_date, :last_incoming_date
    rename_column :inventory_report_items, :last_ship_date, :last_outgoing_date
    rename_column :inventory_report_items, :next_receipt_date, :next_incoming_date
    rename_column :inventory_report_items, :next_ship_date, :next_outgoing_date
    add_column :inventory_report_items, :last_incoming_inventory_transaction_id, :integer
    add_column :inventory_report_items, :next_sales_order_release_id, :integer
    add_column :inventory_report_items, :last_sales_order_release_id, :integer
    add_column :inventory_reports, :earliest_release_date, :datetime
  end

  def down
  end
end