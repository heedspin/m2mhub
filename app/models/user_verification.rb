class UserVerification < ApplicationMailer
  default_url_options[:host] = AppConfig.hostname

  def verification_instructions(user)
    # Rails 3:
    @verification_url = user_verification_url(user.perishable_token, :host => AppConfig.hostname)
    mail( :subject => "#{AppConfig.short_name} M2mhub Account Verification",
          :from => AppConfig.email_address,
          :to => user.email,
          :date => Time.now )
  end

end