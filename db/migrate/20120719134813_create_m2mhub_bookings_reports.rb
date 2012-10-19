class CreateM2mhubBookingsReports < ActiveRecord::Migration
  def up
    create_table :bookings_reports, :force => true do |t|
      t.references :report_time_period
      t.date :date
      t.text :data
      t.decimal :bookings, :precision => 12, :scale => 2
      t.decimal :ytd_bookings, :precision => 12, :scale => 2
      t.timestamps
    end
    add_column :backlog_reports, :data, :text
    remove_column :sales_reports, :bookings
  end

  def down
    add_column :sales_reports, :bookings, :decimal,              :precision => 12, :scale => 2
    remove_column :backlog_reports, :data
    drop_table :bookings_reports
  end
end
