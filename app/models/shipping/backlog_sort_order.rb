require 'plutolib/active_hash_methods'
class Shipping::BacklogSortOrder < ActiveHash::Base
  self.data = [
    { :id => 1, 
    	:name => 'Cust, SO, PN', 
    	:cmethod => 'customer_so_pn',
    	:order_sql => 'somast.fcompany, sorels.fsono, sorels.fpartno' },
    {:id => 2, 
    	:name => 'Cust, PN, Due Date', 
    	:cmethod => 'customer_pn_duedate',
      :order_sql => 'somast.fcompany, sorels.fpartno, sorels.fduedate' }
  ]
  include Plutolib::ActiveHashMethods
end
