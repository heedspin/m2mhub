class M2mhub::UserActivitiesController < M2mhubController
  filter_access_to_defaults
  
  def index
		@user_activities = if permitted_to?(:manage, :m2mhub_user_activities)
      M2mhub::UserActivity.by_date_desc
    else
      M2mhub::UserActivity.for_user(current_user).by_date_desc
    end
    @user_activities = @user_activities.paginate(:page => params[:page], :per_page => 50)
  end
end