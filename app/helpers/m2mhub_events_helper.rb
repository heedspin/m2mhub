module M2mhubEventsHelper
  # def link_to_event_erp_object(event)
  #   case event.trigger_type.method
  #   when :sales_order
  #     link_to "Sales Order #{event.erp_number}", sales_order_url(event.erp_id)
  #   when :shipper
  #     link_to "Shipper #{event.erp_number}", shipper_url(event.erp_id)
  #   when :receiver
  #     link_to "Receiver #{event.erp_number}", receiver_url(event.erp_id)
  #   end
  # end
  
  def link_to_event_status(event)
    case event.trigger.notification_type.cmethod
    when :ticket
      if ticket = event.ticket
        link_to image_tag(AppConfig.lighthouse_image, :width => 16) + ' ' + ticket.state, ticket.url
      else
        "No ticket"
      end
    when :email
      if event.user
        "Email sent to #{event.user.full_name}"
      else
        "No email sent"
      end
    when :nothing
      'No notification'
    else
      "Unexpected notification type: #{event.trigger.notification_type.cmethod}"
    end
  end
end
