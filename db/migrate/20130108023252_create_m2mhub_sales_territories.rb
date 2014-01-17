class CreateM2mhubSalesTerritories < ActiveRecord::Migration
  def up
    create_table :sales_territories, :force => true do |t|
      t.string :name
      t.string :sales_rep_name
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :sales_territories
  end
end