class M2mhubAddBacklogFilters < ActiveRecord::Migration
  def up
    add_column :sales_backlog_reports, :due_after, :date
    add_column :sales_backlog_reports, :page_per_customer, :boolean
    add_column :sales_backlog_reports, :backlog_group_id, :integer
  end

  def down
    remove_column :sales_backlog_reports, :backlog_group_id
    remove_column :sales_backlog_reports, :page_per_customer
    remove_column :sales_backlog_reports, :due_after
  end
end
