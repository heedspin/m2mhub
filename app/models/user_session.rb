class UserSession < Authlogic::Session::Base
  private
    validate :check_if_verified
    def check_if_verified
      case attempted_record.try(:user_status_id)
      when UserStatus.active.id
        # Success!
      when UserStatus.suspended.id
        errors.add(:base, "This account has been suspended")
      when UserStatus.unconfirmed.id
        errors.add(:base, "This account not yet been verified")
      else
        errors.add(:base, "This account does not exist")
      end
    end
end
