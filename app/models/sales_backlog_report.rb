class SalesBacklogReport < ApplicationModel
  belongs_to_active_hash :report_status, :class_name => 'ReportStatus'
  belongs_to_active_hash :fob_group
  belongs_to_active_hash :customer_status, :class_name => 'M2m::CustomerStatus'
  belongs_to_active_hash :backlog_group
end

# == Schema Information
#
# Table name: sales_backlog_reports
#
#  id                 :integer(4)      not null, primary key
#  due_date           :date
#  report_status_id   :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#  fob_group_id       :integer(4)
#  customer_status_id :integer(4)
#  due_after          :date
#  page_per_customer  :boolean(1)
#  backlog_group_id   :integer(4)
#

