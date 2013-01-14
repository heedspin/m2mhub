class AddM2mhubSalesCustomerRepStatusAndLeadLevel < ActiveRecord::Migration
  def up
    add_column :sales_customers, :lead_level_id, :integer
    add_column :sales_customers, :rep_status_id, :integer
    execute "update sales_customers set rep_status_id = #{Sales::RepStatus.unassigned.id}"
  end

  def down
    remove_column :sales_customers, :rep_status_id
    remove_column :sales_customers, :lead_level_id
  end
end