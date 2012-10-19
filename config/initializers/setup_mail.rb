# # Gmail setup
# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = {
#   :enable_starttls_auto => true,
#   :address => 'smtp.gmail.com',
#   :port => 587,
#   :authentication => :plain,
#   :domain => 'smtcoinc.heroku.com',
#   :user_name => 'smtcoinc@gmail.com',
#   :password => ENV['email_password'] || File.read(Rails.root + 'config/email_password.txt')
# }

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => ENV['email_domain'] || AppConfig.email_domain,  
  :user_name            => ENV['email_address'] || AppConfig.email_address,
  :password             => ENV['email_password'] || AppConfig.email_password,
  :authentication       => "plain", 
  :enable_starttls_auto => true,
  :raise_delivery_errors => Rails.env.development?
}