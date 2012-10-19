class CreateM2mhubCustomerReports < ActiveRecord::Migration
  def up
    create_table :customer_reports, :force => true do |t|
      t.string :customer_number
      t.decimal :total_quote_amount, :precision => 12, :scale => 2
      t.decimal :total_sales_amount, :precision => 12, :scale => 2
      t.timestamps
    end
  end

  def down
    drop_table :customer_reports
  end
end