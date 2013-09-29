require 'plutolib/active_hash_methods'
class Sales::OpportunityWinTypeSearch < ActiveHash::Base
  self.data = [
  	{:id => 1, :name => 'Any Order', :win_type_ids => [
  		Sales::OpportunityWinType.sample_order,
  		Sales::OpportunityWinType.tooling_order,
  		Sales::OpportunityWinType.production_order].map(&:id)},
    {:id => 2, :name => 'Sample Order', :win_type_ids => [Sales::OpportunityWinType.sample_order.id]},
    {:id => 3, :name => 'Tooling Order', :win_type_ids => [Sales::OpportunityWinType.tooling_order.id]},
    {:id => 4, :name => 'Production Order', :win_type_ids => [Sales::OpportunityWinType.production_order.id]},
  ]
  include Plutolib::ActiveHashMethods
end
