require File.dirname(__FILE__) + '/../test_helper'

class SalesBacklogReportsControllerTest < ActionController::TestCase

  def self.setup
    @@admin = Factory(:user, :user_role => UserRole.admin)
  end

  def test_life
    login @@admin
    get :index, :search => { :due_date => '10/17/2011', :customer_status_id => M2m::CustomerStatus.credit_hold.id }
    assert_response :success
  end
  
end
