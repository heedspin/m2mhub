class SwitchController < ApplicationController
  filter_access_to :switch, :context => :users
  def switch
    if (thing = params[:thing]).present?
      if switch_to = thing.to_i > 0 ? User.find_by_id(thing) : User.find_by_email(thing)
        old_user = current_user.to_trace
        @user_session = UserSession.create(switch_to)
        logger.info("switch: from #{old_user} to #{switch_to.to_trace}")
      end
    end
    redirect_to root_url(:nocache=>1)
  end
end