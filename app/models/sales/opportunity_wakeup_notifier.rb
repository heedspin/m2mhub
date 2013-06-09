class Sales::OpportunityWakeupNotifier < ApplicationMailer
  def wakeup_notifier(opportunity)
    @opportunity = opportunity
    @opportunity_url = opportunity_url(opportunity, :host => AppConfig.hostname)
    if opportunity.owner
      mail( :subject => "Wakeup: #{@opportunity.safe_title}",
            :from => AppConfig.email_address,
            :to => @opportunity.owner.email,
            :date => Time.now )
    end
  end

end
