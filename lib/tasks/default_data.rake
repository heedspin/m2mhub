namespace :default_data do
  desc "Load all default data"
  task :all => %w(users content_modules).map{ |task| "default_data:#{task}" }

  desc "Load default users"
  task :users => :environment do
    users = [
      ['Robo', 'Mailer', CompanyConfig.email_address, 'betterchangemequick']
    ]

    users.each do |user|
      next if User.find_by_email(user[2])
      u = User.new
      u.first_name = user[0]
      u.last_name = user[1]
      u.email = user[2]
      u.user_role_id = UserRole.admin.id
      u.user_state_id = UserState.active.id
      if (password = user[3]) and u.crypted_password.nil?
        u.password = u.password_confirmation = password
      end
      u.save(:validate => false)
    end
  end

  desc 'Create all the content modules'
  task :content_modules => [ :environment ] do
    #TODO: How to initialize company-specific content modules?
    # configs = AppConfig.lxd? ? lxd_content_modules : smt_content_modules
    # configs.each do |config|
    #   ContentModule.make! config
    # end
  end
end
