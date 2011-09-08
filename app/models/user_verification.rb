class UserVerification < ApplicationMailer
  default_url_options[:host] = AppConfig.hostname

  def verification_instructions(user)
    subject       "m2mhub Account Verification"
    from          AppConfig.email_address
    recipients    user.email
    sent_on       Time.now
    body          :verification_url => user_verification_url(user.perishable_token)
  end

end