class CreateSalesBacklogReports < ActiveRecord::Migration
  def self.up
    create_table :sales_backlog_reports, :force => true do |t|
      t.date :due_date
      t.references :report_status
      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :sales_backlog_reports
  end
end