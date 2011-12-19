module UserActivitiesHelper
  def user_activity_url(user_activity)
    begin
      phash = user_activity.params_hash
      cs = phash['controller']
      if ['customer_otd_reports', 'rma_reports', 'credit_memo_reports'].include?(cs)
        phash['controller'] = 'quality/' + cs
      end
      url_for phash
    rescue ActionView::TemplateError
      user_activity.report_name
    end
  end
end