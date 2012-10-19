class M2mhubCreateSalesReports < ActiveRecord::Migration
  def up
    create_table :sales_reports, :force => true do |t|
      t.references :report_time_period
      t.date :date
      t.text :data
      t.decimal :invoiced_sales, :precision => 12, :scale => 2
      t.decimal :net_invoiced_sales, :precision => 12, :scale => 2
      t.decimal :bookings, :precision => 12, :scale => 2
      t.timestamps
    end
    
    create_table :backlog_reports, :force => true do |t|
      t.date :date
      t.decimal :total_backlog, :precision => 12, :scale => 2
      t.timestamps
    end
  end

  def down
    drop_table :backlog_reports
    drop_table :sales_reports
  end
end