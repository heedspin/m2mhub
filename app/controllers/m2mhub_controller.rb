# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'menu_selected'
require 'pdf_generation'
require 'declarative_authorization'
require 'active_hash'
require 'm2mhub_current_user'
require 'm2mhub/require_login'

class M2mhubController < ApplicationController
  include MenuSelected
  include PdfGeneration
  include M2mhub::RequireLogin # ApplicationController probably also includes this, but we're having trouble finding it.
  include Authorization::AuthorizationInController
  helper Authorization::AuthorizationHelper

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :record_current_user
  
  protected
  
    def record_current_user
      M2mhubCurrentUser.user = current_user
      true
    end
  
    def value_to_bool(val)
      ActiveRecord::ConnectionAdapters::Column.value_to_boolean(val)
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
