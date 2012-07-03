class CreateSalesReports < ActiveRecord::Migration
  def up
    create_table :sales_reports, :force => true do |t|
      t.references :report_time_period
      t.date :date
      t.text :data
      t.decimal :period_invoiced_sales, :precision => 12, :scale => 2
      t.decimal :period_bookings, :precision => 12, :scale => 2
      t.timestamps
    end
  end

  def down
    drop_table :sales_reports
  end
end