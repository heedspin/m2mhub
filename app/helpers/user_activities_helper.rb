module UserActivitiesHelper
  def user_activity_url(user_activity)
    begin
      cs = user_activity.params_hash['controller']
      if ['customer_otd_reports', 'rma_reports', 'credit_memo_reports'].include?(cs)
        user_activity.params_hash['controller'] = 'quality/' + cs
      end
      url_for user_activity.params_hash
    rescue ActionView::TemplateError
      user_activity.report_name
    end
  end
end