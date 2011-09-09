class UserActivitiesController < ApplicationController
  filter_access_to_defaults
  
  def index
    @user_activities = UserActivity.paginate(:all, :page => params[:page], :per_page => 50, :order => 'created_at desc')
  end
end