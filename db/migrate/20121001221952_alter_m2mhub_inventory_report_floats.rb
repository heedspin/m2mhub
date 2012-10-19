class AlterM2mhubInventoryReportFloats < ActiveRecord::Migration
  def self.targets
    [ [Production::InventoryReport, %w(total_on_hand_cost total_on_order_cost total_available_cost total_committed_cost)],
      [Production::InventoryReportItem, %w(quantity_on_hand quantity_committed quantity_available quantity_on_order cost)],
      [Production::InventoryReportCustomer, %w(total_on_hand_cost total_on_order_cost total_available_cost total_committed_cost)] ]
  end

  def up
    self.class.targets.each do |klass, columns|
      columns.each do |col|
        rename_column klass.table_name, col, "old_#{col}"
        add_column klass.table_name, col, :decimal, :precision => 12, :scale => 2
      end
      klass.find_each do |o|
        columns.each do |col|
          if old_val = o.send("old_#{col}")
            o.send("#{col}=", old_val.round(4))
          end
        end
        o.save!
      end
    end
  end

  def down
    self.class.targets.each do |klass, columns|
      columns.each do |col|
        remove_column klass.table_name, col
        rename_column klass.table_name, "old_#{col}", col
      end
    end
  end
end
