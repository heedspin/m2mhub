module UserActivitiesHelper
  def user_activity_url(user_activity)
    url_for user_activity.params_hash
  end
end