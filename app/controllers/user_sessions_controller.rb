class UserSessionsController < M2mhubController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_not_logged_in, :only => [:new,:create]

  def new
    @user_session ||= UserSession.new
  end
  
  def create
    @user_session = UserSession.new(email: params[:user_session]['email'],
      password: params[:user_session]['password'], 
      remember_me: params[:user_session]['remember_me'])
    if @user_session.save
      flash[:notice] = "Login successful"
      redirect_back_or_default root_url
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
