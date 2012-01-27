class MaterialAvailabilityReport

  class LineItem
    attr_accessor :number, :type_weighting, :supply, :demand, :status, :target_date, :actual_date, :net_availability, :count_supply_and_demand
    def today?
      self.is_a?(TodayLineItem)
    end
    def sales_order?
      self.is_a?(SalesLineItem)
    end
    def purchase_order?
      self.is_a?(PurchaseLineItem)
    end
    def inventory_transactions?
      self.is_a?(InventoryLineItem)
    end
    def receiver?
      self.is_a?(ReceiverLineItem)
    end
    def shipper?
      self.is_a?(ShipperLineItem)
    end
    def closed?
      true
    end
    def date
      d = (self.actual_date || self.target_date)
      Date.new(d.year, d.month, d.day)
    end
    def <=>(rhs)
      [self.date, self.type_weighting, (self.number || 0).to_s] <=> [rhs.date, rhs.type_weighting, (rhs.number || 0).to_s]
    end
    def count_supply_and_demand?
      @count_supply_and_demand
    end
  end

  class TodayLineItem < LineItem
    def initialize
      self.actual_date = Date.current
      self.type_weighting = 5
    end
  end

  class SalesLineItem < LineItem
    attr :sales_order
    def initialize(sales_order)
      @sales_order = sales_order
      self.type_weighting = 3
      self.number = @sales_order.sales_order_release_id
      self.demand = if @sales_order.closed?
        @sales_order.quantity_shipped
      elsif @sales_order.quantity_shipped > 0
        @sales_order.quantity_shipped
      else
        @sales_order.quantity
      end
      self.status = @sales_order.status
      self.target_date = @sales_order.due_date
      self.actual_date = @sales_order.last_ship_date
      self.count_supply_and_demand = !self.status.on_hold?
    end
    def closed?
      # TODO: Perhaps make this policy a configuration option.
      # We're considering sales orders closed when the last ship date passes.
      # I don't understand this policy, but M2M's ma report appears to run this way.
      !@status.open? || ((@sales_order.last_ship_date || @sales_order.due_date) < Date.current)
    end
  end

  class PurchaseLineItem < LineItem
    attr :purchase_order_item
    def initialize(purchase_order_item)
      @purchase_order_item = purchase_order_item
      self.type_weighting = 2
      self.number = @purchase_order_item.release
      self.supply = get_supply
      self.status = @purchase_order_item.status
      self.target_date = @purchase_order_item.last_promise_date
      self.actual_date = @purchase_order_item.date_received
      d = self.actual_date || self.target_date
      self.count_supply_and_demand = d.present? && (d >= Date.current)
    end
    def closed?
      # TODO: Perhaps make this policy a configuration option.
      # We're considering purchase orders closed when the last promise date passes.
      # I don't understand this policy, but M2M's ma report appears to run this way.
      !@status.open? || (@purchase_order_item.last_promise_date < Date.current)
    end

    protected

      def get_supply
        if @purchase_order_item.closed?
          @purchase_order_item.quantity_received
        elsif @purchase_order_item.master_release?
          @purchase_order_item.master_remainder_quantity
        elsif @purchase_order_item.quantity_received > 0
          @purchase_order_item.quantity_received
        else
          @purchase_order_item.quantity
        end
      end
  end

  class InventoryLineItem < LineItem
    attr :inventory_transaction
    def initialize(inventory_transaction)
      @inventory_transaction = inventory_transaction
      self.type_weighting = 1
      self.supply = @inventory_transaction.quantity
      self.actual_date = @inventory_transaction.date
      self.count_supply_and_demand = !(@inventory_transaction.transaction_type.receipts? or  @inventory_transaction.transaction_type.issues? or @inventory_transaction.transaction_type.transfers?)
    end
  end

  class ReceiverLineItem < LineItem
    attr :receiver_item
    def initialize(receiver_item)
      @receiver_item = receiver_item
      self.type_weighting = 0
      self.supply = @receiver_item.quantity
      self.actual_date = @receiver_item.receiver.date_received
      self.count_supply_and_demand = true
      self.number = "#{@receiver_item.purchase_order_item_number}-#{@receiver_item.release_number}"
    end
  end

  class ShipperLineItem < LineItem
    attr :shipper_item
    def initialize(shipper_item)
      @shipper_item = shipper_item
      self.type_weighting = 0
      self.demand = @shipper_item.quantity
      self.actual_date = @shipper_item.shipper.ship_date
      self.count_supply_and_demand = true
      # self.number = "#{@shipper_item.purchase_order_item_number}-#{@receiver_item.release_number}"
    end
  end

  attr_reader :item, :line_items, :total_future_supply, :total_future_demand
  attr_reader :sales_order_releases

  def initialize(args)
    @item = args[:item] || (raise ':item required')
    @sales_order_releases = args[:sales_order_releases] || (raise ':sales_order_releases required')
    @purchase_order_items = args[:purchase_order_items] || (raise ':purchase_order_items required')
    @show_history = args[:show_history] || false
    @line_items = []
    run
  end

  def run
    @sales_order_releases.each do |r|
      unless r.master? || r.closed? || (r.backorder_quantity <= 0)
        @line_items.push SalesLineItem.new(r)
      end
    end
    @purchase_order_items.each do |p|
      i = PurchaseLineItem.new(p)
      @line_items.push i unless i.closed?
    end
    if @show_history
      @item.inventory_transactions.each do |t|
        next if t.ftype.blank?
        raise "Unhandled transaction type: #{t.ftype}" if t.transaction_type.nil?
        next if (t.transaction_type.receipts? or t.transaction_type.issues?)
        @line_items.push i = InventoryLineItem.new(t)
      end
      @item.receiver_items.all(:include => :receiver).each do |r|
        @line_items.push ReceiverLineItem.new(r)
      end
      @item.shipper_items.all(:include => :shipper).each do |s|
        @line_items.push ShipperLineItem.new(s)
      end
      @line_items.push TodayLineItem.new
    end

    @line_items.sort!

    # Calculate net availability
    net_availability = @show_history ? 0.0 : item.quantity_on_hand || 0.0
    @total_future_supply = item.quantity_on_hand
    @total_future_demand = 0
    @line_items.each do |line_item|
      if line_item.count_supply_and_demand?
        supply = (line_item.supply || 0.0)
        demand = (line_item.demand || 0.0)
        net_availability = line_item.net_availability = net_availability + supply - demand
        unless line_item.closed?
          @total_future_supply += supply
          @total_future_demand += demand
        end
      else
        line_item.net_availability = net_availability
      end
    end
  end
end
