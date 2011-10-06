class M2m::SalesCustomerMaster < M2m::Base
  set_table_name 'slcdpm'
  set_primary_key 'fcustno'
  
  alias_attribute :notes, :fmnotes
end
