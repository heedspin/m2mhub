class M2mhub::SalesOrderTriggerRunner < M2mhub::TriggerRunnerBase
  include ActionView::Helpers::UrlHelper
  include FormatHelper
  def run
    earliest_time = Time.current.advance(:days => Rails.env.development? ? -60 : -2)
    sales_order_releases = M2m::SalesOrderRelease.part_number_starts_with(@trigger.part_number).ordered_since(earliest_time)
    recent_events = @trigger.events.since(earliest_time).all
    if recent_events.size > 0
      sales_order_releases = sales_order_releases.where(["#{M2m::SalesOrderRelease.table_name}.fsono not in (?)", recent_events.map(&:erp_number)])
    end
    sales_orders = sales_order_releases.inject({}) { |sales_orders,release|
      (sales_orders[release.sales_order_number] ||= []).push(release)
      sales_orders
    }
    result = 0
    sales_orders.values.each do |releases|
      so = releases.first.sales_order
      log "Creating event for sales order #{so.order_number}"
      new_event = @trigger.events.build
      new_event.erp_type = 'M2m::SalesOrder'
      new_event.erp_id = so.id
      new_event.erp_number = so.order_number
      new_event.user = @trigger.target_user
      url = Rails.application.routes.url_helpers.sales_order_url(so, :host => AppConfig.hostname)
      new_event.title = "#{@trigger.title}: " + link_to("SO #{so.order_number}", url)
      num_releases = releases.size
      quantity = releases.sum { |r| r.master? ? 0 : r.order_quantity }
      release_summary = "#{cm(quantity, :sales_order_quantity)} in #{cm(num_releases, :sales_order_quantity, 0)} releases."
      new_event.body = release_summary
      if @trigger.notification_type.ticket?
        title = "#{@trigger.title}: SO #{so.order_number} for #{@trigger.part_number}"
        body = []
        body.push "[Sales Order #{so.order_number}](#{url})"
        body.push release_summary
        body.push @trigger.instructions
        new_event.create_ticket(title, body.join("\n\n"))
      end
      new_event.save!
      result += 1
    end
    result
  end
  
  def _run
    earliest_time = Time.current.advance(:days => Rails.env.development? ? -60 : -2)
    # sales_order_items = M2m::SalesOrderItem.scoped(:conditions => ['soitem.fpartno like ?', @trigger.part_number + '%']).ordered_since(earliest_time)
    recent_events = @trigger.events.since(earliest_time).all
    if recent_events.size > 0
      sales_order_items = sales_order_items.joins(:sales_order).where(["#{M2m::SalesOrderItem.table_name}.identity_column not in (?)", recent_events.map(&:erp_id)])
    end
    sales_order_items.each do |soi|
      log "Creating event for sales order #{soi.order_number}"
      new_event = @trigger.events.build
      new_event.erp_type = 'M2m::SalesOrderItem'
      new_event.erp_id = soi.id
      new_event.erp_number = soi.order_number
      new_event.user = @trigger.target_user
      url = Rails.application.routes.url_helpers.sales_order_url(soi.sales_order, :host => AppConfig.hostname)
      new_event.title = "#{@trigger.title}: " + link_to("SO #{soi.order_number}", url)
      if @trigger.notification_type.ticket?
        title = "#{@trigger.title}: SO #{soi.order_number} for #{soi.part_number}"
        body = "[Sales Order #{soi.order_number}](#{url})\n\n#{@trigger.instructions}"
        new_event.create_ticket(title, body)
      end
      new_event.save
    end
    true
  end
end