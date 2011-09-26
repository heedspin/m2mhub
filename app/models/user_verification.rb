class UserVerification < ApplicationMailer
  default_url_options[:host] = CompanyConfig.hostname

  def verification_instructions(user)
    subject       "m2mhub Account Verification"
    from          CompanyConfig.email_address
    recipients    user.email
    sent_on       Time.now
    body          :verification_url => user_verification_url(user.perishable_token)
  end

end