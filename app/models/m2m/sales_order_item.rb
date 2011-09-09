class M2m::SalesOrderItem < M2m::Base
  default_scope :order => :fenumber
  set_table_name 'soitem'
  belongs_to :sales_order, :class_name => 'M2m::SalesOrder', :foreign_key => :fsono
end
