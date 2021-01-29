class HomeController < M2mhubController
  def index
    if permitted_to? :read, :sales_reports
      @sales_orders = M2m::SalesOrder.by_order_number_desc.limit(10).includes(:releases, :items)
      # Optimization:
      @sales_orders.each do |so|
        so.releases.each { |r| r.attach_items_from_sales_order(so) }
        so.items.each { |i| i.attach_releases_from_sales_order(so) }
      end
      yesterday = Date.current.advance(:days => -1)
      @quotes = M2m::Quote.since(yesterday).all
      if AppConfig.enable_events?
        @events = M2mhub::Event.latest_first.open_or_recently_closed.valid
      end
      @date_reports = Sales::DateReport.create( :sales_reports => Sales::SalesReport.by_date_desc.limit(8),
                                                :bookings_reports => Sales::BookingsReport.by_date_desc.limit(8) )
      @backlog_report = Sales::BacklogReport.by_date_desc.first
      if M2mhub::Feature.enabled?(:opportunities)
        @search = Sales::SalesEvent::Search.new(:end_date => Date.current, :start_date => Date.current.advance(:days => -3))
        @sales_events = Sales::SalesEvent.search(@search).sort_by(&:date).reverse[0..15]
      end
    elsif current_user.user_role.shipping?
      redirect_to shipping_backlog_reports_url
    else
      redirect_to doogle_displays_url
    end
  end
end
