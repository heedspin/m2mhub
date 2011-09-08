class UsersController < ApplicationController
  filter_access_to_defaults
  before_filter :require_login, :only => [:index, :show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = current_object
  end

  # GET /users/new
  def new
    @user = build_object
  end

  # GET /users/1/edit
  def edit
    @user = current_object
  end

  # POST /users
  def create
    @user = build_object
    respond_to do |format|
      if @user.save
        format.html {
          if current_user
            flash[:notice] = 'User was successfully created.'
            redirect_to(@user)
          else
            flash[:notice] = 'A verification email has been sent.'
            @user.deliver_verification_instructions!
            redirect_to root_url(:nocache=>1)
          end
        }
        format.json { render :nothing => true, :status => :created }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  def update
    @user = current_object

    if @user.save
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user)
    else
      render :action => "edit"
    end
  end

  # GET /users/1/delete
  def delete
    @user = User.find(params[:id])
    @user.delete
    redirect_to(users_url)
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.id == current_user.id
      current_user_session.destroy
      flash[:notice] = "Account deleted"
      redirect_to(root_url(:nocache=>1))
    else
      redirect_to(users_url)
    end
  end

  protected

    def current_object
      @current_object ||= get_user_object(:find)
    end

    def build_object
      @current_object ||= get_user_object(:new)
    end

    def get_user_object(method)
      if @current_object.nil?
        user_params = params[:user] || {}
        user_role_id = user_params.delete(:user_role_id)
        user_status_id = user_params.delete(:user_status_id)
        user_password = user_params.delete(:password)
        user_password_confirmation = user_params.delete(:password_confirmation)
        @current_object = method == :new ? User.new(user_params) : User.find(params[:id])
        if permitted_to? :manage, @current_object
          @current_object.user_status_id = user_status_id if user_status_id.present?
          @current_object.user_role_id = user_role_id if user_role_id.present?
        end
        if user_password
          @current_object.password = user_password
          @current_object.password_confirmation = user_password_confirmation
        end
      end
      @current_object
    end
end
