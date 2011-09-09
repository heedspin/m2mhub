class M2m::SalesOrder < M2m::Base
  set_table_name 'somast'
  
  named_scope :open,      :conditions => { :fstatus => M2m::SalesOrderStatus.open.name }
  named_scope :closed,    :conditions => { :fstatus => M2m::SalesOrderStatus.closed.name }
  named_scope :cancelled, :conditions => { :fstatus => M2m::SalesOrderStatus.cancelled.name }
end