class CleanM2mhubInventoryReportFloats < ActiveRecord::Migration
  def self.targets
    [ [Production::InventoryReport, %w(total_on_hand_cost total_on_order_cost total_available_cost total_committed_cost)],
      [Production::InventoryReportItem, %w(quantity_on_hand quantity_committed quantity_available quantity_on_order cost)],
      [Production::InventoryReportCustomer, %w(total_on_hand_cost total_on_order_cost total_available_cost total_committed_cost)] ]
  end

  def up
    self.class.targets.each do |klass, columns|
      columns.each do |col|
        remove_column klass.table_name, "old_#{col}"
      end
    end
  end

  def down
    self.class.targets.each do |klass, columns|
      columns.each do |col|
        add_column klass.table_name, "old_#{col}", :float
        execute "update #{klass.table_name} set old_#{col} = #{col}"
      end
    end
  end
end
