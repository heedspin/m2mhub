class RenameM2mhubQuoteCustomerId < ActiveRecord::Migration
  def up
    rename_column :sales_quotes, :customer_id, :sales_customer_id
  end

  def down
    rename_column :sales_quotes, :sales_customer_id, :customer_id
  end
end