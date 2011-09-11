class PasswordResetNotifier < ActionMailer::Base
  default_url_options[:host] = CompanyConfig.hostname

  def password_reset_instructions(user)
    # Rails 3:
    # @edit_password_reset_url = edit_password_reset_url(user.perishable_token, :host => CompanyConfig.hostname)
    # mail( :subject => "#{CompanyConfig.company_key.upcase} M2mhub Password Reset Instructions",
    #       :from => CompanyConfig.email_address,
    #       :to => user.email,
    #       :date => Time.now )

    subject    "#{CompanyConfig.company_key.upcase} M2mhub Password Reset Instructions"
    from       CompanyConfig.email_address
    recipients user.email
    sent_on    Time.now
    body       :edit_password_reset_url => edit_password_reset_url(user.perishable_token)

  end

end
