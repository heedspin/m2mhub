require 'plutolib/active_hash_methods'
class Production::InventoryReportQuantity < ActiveHash::Base
  self.data = [
    {:id => 1, :key => :on_hand},
    {:id => 2, :key => :on_order},
    {:id => 3, :key => :committed},
    {:id => 4, :key => :available},
  ]
  include Plutolib::ActiveHashMethods
  def total_cost_key
    "total_#{self.key}_cost"
  end
  def quantity_key
    "quantity_#{self.key}"
  end
  def name
    self.key.to_s.titleize
  end

  module Helper
    def add_to_totals(source)
      Production::InventoryReportQuantity.all.each do |quantity|
        value = (self.send(quantity.total_cost_key) || 0) + (source.send(quantity.total_cost_key) || 0)
        self.send "#{quantity.total_cost_key}=", value
      end
      self.movements.add(source.movements)
    end
  end

end

