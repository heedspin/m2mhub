class PasswordsController < ApplicationController
  filter_access_to :edit, :update, :attribute_check => true, :load_method => :current_object, :context => :users

  def edit
    @user = current_object
  end

  def update
    @user = current_object
    if permitted_to?(:update_without_current_password, :users_password) or @user.valid_password?(params[:user][:current_password])
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if params[:user][:password].blank?
        flash.now[:error] = "Please enter a new password."
        render :action => :edit
      else
        if @user.save
          @user_session = UserSession.create(@user)          
          flash[:notice] = "Password changed."
          redirect_to user_url(@user)
        else
          flash.now[:error] = "There was a problem setting your password."
          render :action => :edit
        end
      end
    else
      flash.now[:error] = "The current password you entered is incorrect."
      render :action => :edit
    end
  end

  protected

    def current_object
      @current_object ||= User.find(params[:user_id])
    end

end
