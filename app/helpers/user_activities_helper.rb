module UserActivitiesHelper
  def user_activity_url(user_activity)
    begin
      url_for user_activity.params_hash
    rescue ActionView::TemplateError
      user_activity.report_name
    end
  end
end