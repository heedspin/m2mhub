class CreateM2mhubCommissionTables < ActiveRecord::Migration
  def up
    create_table :commission_rates, :force => true do |t|
      t.references :customer
      t.string :customer_name
      t.string :customer_number
      t.references :sales_person
      t.string :sales_person_name
      t.references :item
      t.string :part_number
      t.decimal :commission_percentage, :precision => 12, :scale => 4
      t.timestamps
    end
  end

  def down
    drop_table :commission_rates
  end
end
