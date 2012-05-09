class M2mhubAddSalesBacklogReportOptions < ActiveRecord::Migration
  def self.up
    add_column :sales_backlog_reports, :fob_group_id, :integer
    add_column :sales_backlog_reports, :customer_status_id, :integer
  end

  def self.down
    remove_column :sales_backlog_reports, :customer_status_id
    remove_column :sales_backlog_reports, :fob_group_id
  end
end