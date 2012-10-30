class AddInventoryReportPrecision < ActiveRecord::Migration
  def up
    change_column :inventory_report_items, :cost, :decimal, :precision => 14, :scale => 4
  end

  def down
    change_column :inventory_report_items, :cost, :decimal, :precision => 12, :scale => 2
  end
end