class M2mhub::SalesOrderTriggerRunner < M2mhub::TriggerRunnerBase
  include ActionView::Helpers::UrlHelper
  def run
    earliest_time = Time.current.advance(:days => Rails.env.development? ? -60 : -2)
    sales_order_items = M2m::SalesOrderItem.scoped(:conditions => ['soitem.fpartno like ?', @trigger.part_number + '%']).ordered_since(earliest_time)
    recent_events = @trigger.events.since(earliest_time).all
    if recent_events.size > 0
      sales_order_items = sales_order_items.scoped(:conditions => ["#{M2m::SalesOrderItem.table_name}.identity_column not in (?)", recent_events.map(&:erp_id)])
    end
    sales_order_items.each do |soi|
      log "Creating event for sales order #{soi.order_number}"
      new_event = @trigger.events.build
      new_event.erp_type = 'M2m::SalesOrderItem'
      new_event.erp_id = soi.id
      new_event.erp_number = soi.order_number
      new_event.user = @trigger.target_user
      url = Rails.application.routes.url_helpers.sales_order_url(soi.sales_order, :host => AppConfig.hostname)
      new_event.m2mhub_summary = "#{@trigger.title}: " + link_to("SO #{soi.order_number}", url)
      if @trigger.notification_type.ticket?
        title = "#{@trigger.title}: SO #{soi.order_number} for #{soi.part_number}"
        body = "[Sales Order #{soi.order_number}](#{url})\n\n#{@trigger.instructions}"
        new_event.create_ticket(@trigger.lighthouse_project_id, title, body)
      end
      new_event.save
    end
    true
  end
end