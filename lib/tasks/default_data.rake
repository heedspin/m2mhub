namespace :m2mhub do
  desc "Create default user"
  task :create_default_user => :environment do
    users = [
      ['Robo', 'Mailer', AppConfig.email_address, 'betterchangemequick']
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
end
