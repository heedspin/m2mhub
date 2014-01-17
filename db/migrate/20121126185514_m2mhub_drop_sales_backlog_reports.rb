class M2mhubDropSalesBacklogReports < ActiveRecord::Migration
  def up
    drop_table :sales_backlog_reports
  end

  def down
  end
end
