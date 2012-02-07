class UserActivitiesController < ApplicationController
  filter_access_to_defaults
  
  def index
		@user_activities = if permitted_to?(:manage, :user_activities)
      UserActivity.by_date_desc
    else
      UserActivity.for_user(current_user).by_date_desc
    end
    @user_activities = @user_activities.paginate(:page => params[:page], :per_page => 50)
  end
end