class Sales::OpportunityNotifier < ApplicationMailer
  def wakeup_notifier(opportunity)
    @opportunity = opportunity
    @opportunity_url = opportunity_url(opportunity, :host => AppConfig.hostname)
    if opportunity.owner
      mail( :subject => "Wakeup: #{@opportunity.safe_title}. #{@opportunity.xnumber}",
            :from => AppConfig.email_address,
            :to => @opportunity.owner.email,
            :date => Time.now )
    end
  end

  def reminder_notifier(comment)
    @comment = comment
    @opportunity = comment.opportunity
    @opportunity_url = opportunity_url(@opportunity, :host => AppConfig.hostname)
    if @opportunity.owner
      mail( :subject => "Reminder: #{@opportunity.safe_title}. #{@opportunity.xnumber}",
            :from => AppConfig.email_address,
            :to => @opportunity.owner.email,
            :date => Time.now )
    end
  end

  def new_opportunity_notifier(opportunity)
    @opportunity = opportunity
    @opportunity_url = opportunity_url(@opportunity, :host => AppConfig.hostname)
    if @opportunity.owner
      mail( :subject => "#{@opportunity.safe_title}. Ticket #{@opportunity.xnumber}",
            :from => AppConfig.email_address,
            :to => @opportunity.owner.email,
            :date => Time.now )
    end
  end

end
