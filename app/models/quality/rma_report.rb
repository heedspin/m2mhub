class Quality::RmaReport
  class Month
    attr_accessor :date, :total_shipments, :rma_quantity, :rmas
    def initialize(date)
      @date = date
      @total_shipments = @rma_quantity = 0.0
      @rmas = []
    end
    def add_rma(rma)
      rma.items.each { |i| @rma_quantity += i.quantity }
      @rmas.push(rma)
    end
    def total_rmas
      @rmas.size
    end
  end

  def initialize(args=nil)
    args ||= {}
    @start_date = args[:start_date] ||= Date.current.beginning_of_year
    @end_date = args[:end_date] || @start_date.advance(:years => 1)
    @months = {}
  end
  
  def run
    rmas = M2m::Rma.between(@start_date, @end_date).scoped(:include => :items).all
    if M2mhub::Feature.enabled?(:inspection_tasks)
      Quality::InspectionTask.attach_to_rmas(rmas)
    end
    customers = M2m::Customer.with_customer_numbers(rmas.map(&:customer_number)).all
    items = M2m::Item.with_part_numbers(rmas.map(&:items).flatten.map(&:part_number)).all
    total_shipments = M2m::Shipper.monthly_quantity_shipped(@start_date, @end_date)
    rmas.each do |rma|
      month = month_for(rma.date)
      month.add_rma(rma)
      rma.items.each do |rma_item|
        if found = items.detect { |c| (c.part_number == rma_item.part_number) && (c.revision == rma_item.revision) }
          rma_item.item = found
        end
      end
      rma.customer = customers.detect { |c| c.customer_number == rma.customer_number }
    end
    @months.values.each do |month|
      month.total_shipments = total_shipments[month.date]
    end
    true
  end

  def ordered_months
    @months.values.sort_by(&:date)
  end
  
  def month_for(date)
    month_date = Date.new(date.year, date.month, 1)
    @months[month_date] ||= Month.new(month_date)
  end
  
  def all_rmas
    @months.values.map(&:rmas).flatten
  end
end
