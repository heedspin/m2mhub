module M2mhub::RequireLogin
  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to params[:return_to] || session[:return_to] || default
    session[:return_to] = nil
  end

  def require_login
    unless current_user
      respond_to do |format|
        format.html {
          store_location
          if current_user_session.try(:stale?)
            flash[:error] = "Your session has expired. Please log in again."
          else
            flash[:error] = "You must be logged in to access that page."
          end
          redirect_to login_url
        }
        format.json { render :nothing => true, :status => :unauthorized }
      end
      false
    else
      true
    end
  end

  def require_not_logged_in
    if current_user
      redirect_back_or_default root_url
      false
    else
      true
    end
  end

  def self.included(base)
    base.class_eval <<-RUBY
    before_action :require_login
    RUBY
  end
  
end