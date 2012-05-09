class PasswordResetNotifier < ActionMailer::Base
  default_url_options[:host] = AppConfig.hostname

  def password_reset_instructions(user)
    # Rails 3:
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token, :host => AppConfig.hostname)
    mail( :subject => "#{AppConfig.company_key.upcase} M2mhub Password Reset Instructions",
          :from => AppConfig.email_address,
          :to => user.email,
          :date => Time.now )

    # subject    "#{AppConfig.company_key.upcase} M2mhub Password Reset Instructions"
    # from       AppConfig.email_address
    # recipients user.email
    # sent_on    Time.now
    # body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token, :host => AppConfig.hostname)

  end

end
