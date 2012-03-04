class Production::InventoryReport
  class Inventory
    attr_accessor :item, :allocated_to_customer
    def initialize(item, allocated_to_customer)
      @item = item
      @allocated_to_customer = allocated_to_customer
    end
    def cost
      if @item.standard_cost
        @item.standard_cost * (@item.quantity_on_hand + @item.quantity_in_inspection)
      else
        0
      end
    end
  end
  class CustomerReport
    attr_accessor :customer, :inventories
    def initialize(customer)
      @customer = customer
      @inventories = []
    end
    def add_inventory(inventory)
      @inventories.push inventory
    end
    def total_cost
      @inventories.sum do |i|
        i.allocated_to_customer == self.customer ? i.cost : 0
      end
    end
  end

  def initialize(args=nil)
    args ||= {}
    @customer_reports = {}
  end
  
  def run
    locations = M2m::InventoryLocation.with_quantity_on_hand
    items = M2m::Item.attach_items(locations)
    no_customer = CustomerReport.new(nil)
    items.each do |item|
      allocated_to_customer = item.customers.first || no_customer
      inventory = Inventory.new(item, allocated_to_customer)
      customer_report = @customer_reports[allocated_to_customer.id] ||= CustomerReport.new(allocated_to_customer)
      customer_report.add_inventory(inventory)
    end
    true
  end

  def ordered_customer_reports
    @customer_reports.values.sort_by(&:total_cost)
  end
  
  def total_cost
    @customer_reports.values.sum(&:total_cost)
  end
  
end
