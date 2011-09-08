class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :require_not_logged_in, :only => [:new,:create]

  def new
    @user_session ||= UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful"
      redirect_back_or_default root_url(:nocache=>1)
    else
      flash.now[:error] = "Login unsuccessful"
      render :action => 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default login_url
  end

end
