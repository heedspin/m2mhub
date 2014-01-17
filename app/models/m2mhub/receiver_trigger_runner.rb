class M2mhub::ReceiverTriggerRunner < M2mhub::TriggerRunnerBase
  include ActionView::Helpers::UrlHelper
  def run
    earliest_time = Time.current.advance(:days => Rails.env.development? ? -70 : -2)
    receiver_items = M2m::ReceiverItem.scoped(:conditions => ['rcitem.fpartno like ?', @trigger.part_number + '%']).received_since(earliest_time)
    recent_events = @trigger.events.since(earliest_time).all
    if recent_events.size > 0
      receiver_items = receiver_items.scoped(:conditions => ["#{M2m::ReceiverItem.table_name}.identity_column not in (?)", recent_events.map(&:erp_id)])
    end
    result = 0
    receiver_items.each do |ri|
      log "Creating event for receiver #{ri.receiver_number}"
      new_event = @trigger.events.build
      new_event.erp_type = 'M2m::ReceiverItem'
      new_event.erp_id = ri.id
      new_event.erp_number = ri.receiver_number
      new_event.user = @trigger.target_user
      url = Rails.application.routes.url_helpers.shipping_daily_reports_url(:date => ri.receiver.time_received.to_date.to_s(:database), :host => AppConfig.hostname)
      new_event.title = "#{@trigger.title}: " + link_to("Receiver #{ri.receiver_number}", url)
      if @trigger.notification_type.ticket?
        title = "#{@trigger.title}: Receiver #{ri.receiver_number} for #{ri.part_number}"
        body = "[Receiver #{ri.receiver_number}](#{url})\n\n#{@trigger.instructions}"
        new_event.create_ticket(title, body)
      end
      new_event.save!
      result += 1
    end
    result
  end
end