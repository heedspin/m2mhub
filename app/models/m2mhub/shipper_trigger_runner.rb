class M2mhub::ShipperTriggerRunner < M2mhub::TriggerRunnerBase
  include ActionView::Helpers::UrlHelper
  def run
    earliest_time = Time.current.advance(:days => Rails.env.development? ? -70 : -2)
    items = M2m::ShipperItem.scoped(:conditions => ['shitem.fpartno like ?', @trigger.part_number + '%']).shipped_after(earliest_time)
    recent_events = @trigger.events.since(earliest_time).all
    if recent_events.size > 0
      items = items.scoped(:conditions => ["#{M2m::ShipperItem.table_name}.identity_column not in (?)", recent_events.map(&:erp_id)])
    end
    items.each do |i|
      log "Creating event for shipper #{i.shipper_number}"
      new_event = @trigger.events.build
      new_event.erp_type = 'M2m::ShipperItem'
      new_event.erp_id = i.id
      new_event.erp_number = i.shipper_number
      new_event.user = @trigger.target_user
      url = Rails.application.routes.url_helpers.shippers_url(:date => i.shipper.ship_date.to_date.to_s(:database), :host => AppConfig.hostname)
      new_event.m2mhub_summary = "#{@trigger.title}: " + link_to("Shipper #{i.shipper_number}", url)
      if @trigger.notification_type.ticket?
        title = "#{@trigger.title}: Shipper #{i.shipper_number} for #{i.part_number}"
        body = "[Shipper #{i.shipper_number}](#{url})\n\n#{@trigger.instructions}"
        new_event.create_ticket(@trigger.lighthouse_project_id, title, body)
      end
      new_event.save
    end
    true
  end
end