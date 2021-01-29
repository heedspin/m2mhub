class CreateM2mhubCustomers < ActiveRecord::Migration
  def up
    create_table :parent_companies, :force => true do |t|
      t.string :name
      t.timestamps
    end
    create_table :sales_customers, :force => true do |t|
      t.references :parent_company
      t.string :erp_customer_id
      t.string :name
      t.text :location
      t.references :sales_territory
      t.string :sales_person_id
      t.string :sales_person_name
      t.timestamps
    end
    add_column :sales_opportunities, :sales_customer_id, :integer
  end

  def self.down
    remove_column :sales_opportunities, :sales_customer_id
    drop_table :sales_customers
    drop_table :parent_companies
  end
end