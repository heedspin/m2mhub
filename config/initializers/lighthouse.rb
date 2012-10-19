if AppConfig.lighthouse_account
  Lighthouse.account = AppConfig.lighthouse_account
  Lighthouse.token = AppConfig.lighthouse_token
  require 'lighthouse_project'
  require 'lighthouse_ticket'
  require 'lighthouse_user'
end