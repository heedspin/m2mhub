class AddM2mhubSalesCustomerBusinesTypeAndNotes < ActiveRecord::Migration
  def up
    add_column :sales_customers, :business_type_id, :integer
    add_column :sales_customers, :notes, :text
    add_column :sales_customers, :website, :string
  end

  def self.down
    remove_column :sales_customers, :website
    remove_column :sales_customers, :notes
    remove_column :sales_customers, :business_type_id
  end
end