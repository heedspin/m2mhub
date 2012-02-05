class UserSession < Authlogic::Session::Base
  private
    validate :check_if_verified
    def check_if_verified
      case attempted_record.try(:user_state_id)
      when UserState.active.id
        # Success!
      when UserState.suspended.id
        errors.add(:base, "This account has been suspended")
      when UserState.unconfirmed.id
        errors.add(:base, "This account not yet been verified")
      else
        errors.add(:base, "This account does not exist")
      end
    end
end
