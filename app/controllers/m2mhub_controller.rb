# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'menu_selected'
require 'pdf_generation'
require 'declarative_authorization'
require 'active_hash'

class M2mhubController < ApplicationController
  include MenuSelected
  # include Userstamp
  include PdfGeneration

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user_session, :current_user
  before_filter :set_current_user
  before_filter :require_login
  
  protected

    NO_USER_ACTIVITY_CONTROLLERS = %w()

    around_filter :log_user_activity
    # Log all requests unless one has been explicity logged.
    def log_user_activity
      @log_user_activity_start_time = Time.now.to_f
      yield
      if @last_user_activity.nil? and (not request.xhr?) and (not NO_USER_ACTIVITY_CONTROLLERS.include?(controller_name))
        user_activity do
          { :elapsed_time => Time.current.to_f - @log_user_activity_start_time }
        end
      end
    end

    def user_activity
      begin
        options = yield
        options[:user_id] ||= current_user.try(:id)
        options[:remote_ip] ||= request.try(:remote_ip)
        options[:params] ||= params.try(:to_json)
        options[:report_name] ||= (controller_name || 'no controller') + ' / ' + (action_name || 'no action')
        options[:format] ||= params[:format]# || 'html'
        @last_user_activity = UserActivity.create(options)
      rescue
        logger.error "Ignoring UserActivity exception: #{$!}"
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to params[:return_to] || session[:return_to] || default
      session[:return_to] = nil
    end

    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user
      @current_user ||= current_user_session.try(:record)
    end

    def set_current_user
      Authorization.current_user = current_user
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

    # *********************************************************************
    # Authorization
    def self.filter_access_to_defaults(args={})
      filter_access_to :all, args
      filter_access_to :show, :edit, :update, :destroy, :delete, { :attribute_check => true, :load_method => :current_object }.merge(args)
      filter_access_to :create, :new, { :load_method => :build_object, :attribute_check => true }.merge(args)
    end

    # *********************************************************************
    # Our own version of resource controller:
    def model_name
      controller_name.singularize
    end

    def model_class
      model_name.to_s.camelize.constantize
    end

    def build_object
      @build_object ||= model_class.new(params[model_name])
    end

    def current_object
      @current_object ||= model_class.find(params[:id])
    end

    # *********************************************************************

    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
    rescue_from ActionController::RoutingError, :with => :record_not_found unless Rails.env.development?
    def record_not_found
      request.format = :html
      render :template => "errors/404", :status => 404
    end

    rescue_from Exception, :with => :server_error unless Rails.env.development?
    def server_error(exception)
      begin
        notify_airbrake(exception)
      rescue => hoptoad_exc
        Rails.logger.error "Failed to notify airbrake: #{hoptoad_exc.class.name} #{hoptoad_exc.message}"
      ensure
        Rails.logger.error "Notified airbrake: #{exception.class.name} #{exception.message}" + exception.backtrace.join("\n")
      end

      request.format = :html
      render :template => "errors/500", :status => 500
    end

    rescue_from Authorization::NotAuthorized, :with => :not_authorized
    def not_authorized
      request.format = :html
      render :template => "errors/403", :status => 403
    end

    rescue_from ActionController::MethodNotAllowed, ActionController::UnknownHttpMethod, :with => :method_not_allowed
    def method_not_allowed
      request.format = :html
      render :template => "errors/405.html.erb", :status => 405
    end
end
