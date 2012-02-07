ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# require 'transactional_factories'
# require 'declarative_authorization/maintenance'
# require "authlogic/test_case"
# require 'factory_girl'
# Factory.find_definitions

class ActiveSupport::TestCase
  # include Authorization::TestHelper
  
  # self.use_transactional_fixtures = false
  # self.use_instantiated_fixtures  = false
  # 
  # # Create an active session for a user.
  # def login(user)
  #   if user.is_a?(Symbol) or user.is_a?(String)
  #     user = eval("@#{user}")
  #   end
  #   # Reset session if it already exists.
  #   if @controller
  #     @controller = nil
  #     setup_controller_request_and_response
  #   end
  #   # Handle session timeouts.
  #   user.last_request_at = Time.current
  #   user.save
  #   # User.stamper = user
  #   activate_authlogic
  #   UserSession.create(user)
  #   trace "Logged in #{user.to_trace}"
  # end
end