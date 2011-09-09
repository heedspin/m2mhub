class HomeController < ApplicationController
  def index
    @user_activities = UserActivity.recent.all
  end
end