require 'plutolib/active_hash_methods'
class M2mhub::TriggerType < ActiveHash::Base
  self.data = [
    {:id => 1, :name => 'Sales Order', :cmethod => :sales_order, :runner_class_name => 'M2mhub::SalesOrderTriggerRunner'},
    {:id => 2, :name => 'Receiver', :cmethod => :receiver, :runner_class_name => 'M2mhub::ReceiverTriggerRunner'},
    {:id => 3, :name => 'Shipper', :cmethod => :shipper, :runner_class_name => 'M2mhub::ShipperTriggerRunner'}
  ]
  include Plutolib::ActiveHashMethods
  
  def runner_class
    @runner_class ||= self.runner_class_name.constantize
  end
end

