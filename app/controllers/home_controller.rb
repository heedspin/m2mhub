class HomeController < M2mhubController
  def index
    @sales_orders = M2m::SalesOrder.by_order_number_desc.limit(20)
    # Optimization:
    @sales_orders.each do |so|
      so.releases.each { |r| r.attach_items_from_sales_order(so) }
    end
    yesterday = Date.current.advance(:days => -1)
    @quotes = M2m::Quote.since(yesterday).all
    @events = M2mhub::Event.latest_first.open_or_recently_closed.valid
    if permitted_to? :read, :sales_reports
      @monthly_sales_reports = Sales::SalesReport.by_date_desc.limit(8).all.reverse
    end
  end
end
