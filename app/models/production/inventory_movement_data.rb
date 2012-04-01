class Production::InventoryMovementData
  module Helper
    def movements
      @movements ||= Production::InventoryMovementData.new(self)
    end

    def serialize_movements
      if @movements
        self.movement_data = @movements.to_json
      end
    end

    def self.included(base)
      base.class_eval <<-RUBY
      before_save :serialize_movements
      RUBY
    end
  end

  TTYPES = [M2m::InventoryTransactionType.scrap,
            M2m::InventoryTransactionType.receipts,
            M2m::InventoryTransactionType.issues,
            M2m::InventoryTransactionType.moves,
            M2m::InventoryTransactionType.sales_orders]
  TTYPES.each do |ttype|
    self.class_eval <<-RUBY
    def #{ttype.cmethod}
      @movement_data['#{ttype.cmethod}']
    end
    def #{ttype.cmethod}=(val)
      @movement_data['#{ttype.cmethod}']=val
    end
    def #{ttype.cmethod}_cost
      @movement_data['#{ttype.cmethod}_cost']
    end
    def #{ttype.cmethod}_cost=(val)
      @movement_data['#{ttype.cmethod}_cost']=val.round(4)
    end
    RUBY
  end
  
  attr_accessor :object
  def initialize(object)
    @object = object
    if @object.movement_data.present?
      @movement_data = ActiveSupport::JSON.decode(@object.movement_data)
    end
    @movement_data ||= {}
    TTYPES.each do |ttype|
      self.set_quantity_for(ttype, 0) unless self.quantity_for(ttype)
      self.set_cost_for(ttype, 0.0) unless self.cost_for(ttype)
    end
  end

  def add_transactions(inventory_transactions)
    return unless inventory_transactions and (inventory_transactions.size > 0)
    TTYPES.each do |ttype|
      total = inventory_transactions.select { |it| it.transaction_type == ttype }.sum(&:quantity)
      self.set_quantity_for(ttype, total)
      self.set_cost_for(ttype, total * self.object.cost)
    end
  end
  
  def add(source)
    TTYPES.each do |ttype|
      total_cost = self.cost_for(ttype) + source.cost_for(ttype)
      self.set_cost_for(ttype, total_cost)
    end
  end

  def to_json
    @movement_data.to_json
  end
  
  def quantity_for(ttype)
    self.send(ttype.cmethod)
  end
  
  def set_quantity_for(ttype, val)
    send("#{ttype.cmethod}=", val)
  end
  
  def cost_for(ttype)
    self.send("#{ttype.cmethod}_cost")
  end
  
  def set_cost_for(ttype, val)
    send("#{ttype.cmethod}_cost=", val)
  end
end
