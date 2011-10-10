class MaterialAvailabilityReport

  class LineItem
    attr_accessor :order, :number, :type_weighting, :supply, :demand, :status, :target_date, :actual_date, :net_availability
    def today?
      order.nil?
    end
    def sales_order?
      order.is_a?(M2m::SalesOrderRelease)
    end
    def purchase_order?
      order.is_a?(M2m::PurchaseOrderItem)
    end
    def inventory_transactions?
      order.is_a?(M2m::InventoryTransaction)
    end
    def date
      self.actual_date || self.target_date
    end
    def <=>(rhs)
      [self.date, self.type_weighting, self.number || 0] <=> [rhs.date, rhs.type_weighting, rhs.number || 0]
    end
  end
  
  attr_reader :item, :line_items, :total_supply, :total_demand
  
  def initialize(item, sales_order_releases, purchase_order_items)
    @item = item
    @line_items = []
    sales_order_releases.each do |r|
      # next unless r.backorder_quantity <= 0
      @line_items.push i = LineItem.new
      i.order = r
      i.type_weighting = 2
      i.number = r.sales_order_release_id
      i.demand = r.closed? ? r.quantity_shipped : (r.quantity_shipped > 0 ? r.quantity_shipped : r.quantity)
      i.status = r.status
      i.target_date = r.due_date
      i.actual_date = r.last_ship_date
    end
    purchase_order_items.each do |p|
      # next unless p.backorder_quantity <= 0
      @line_items.push i = LineItem.new
      i.order = p
      i.type_weighting = 1
      i.number = p.item_number
      i.supply = p.closed? ? p.quantity_received : (p.quantity_received > 0 ? p.quantity_received : p.quantity)
      i.status = p.status
      i.target_date = p.last_promise_date      
      i.actual_date = p.date_received
    end
    item.inventory_transactions.each do |t|
      next if (t.transaction_type.receipts? or t.transaction_type.issues? or t.transaction_type.transfers?)
      @line_items.push i = LineItem.new
      i.order = t
      i.type_weighting = 0
      i.supply = t.quantity
      i.actual_date = t.date
    end
    today = LineItem.new
    today.actual_date = Date.current
    @line_items.push today

    @line_items.sort!

    # Calculate net availability
    net_availability = 0.0 #item.quantity_on_hand || 0
    @total_supply = item.quantity_on_hand
    @total_demand = 0
    @line_items.each do |line_item|
      supply = (line_item.supply || 0.0)
      demand = (line_item.demand || 0.0)
      net_availability = line_item.net_availability = net_availability + supply - demand
      @total_supply += supply
      @total_demand += demand
    end
  end
end