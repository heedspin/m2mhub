namespace :site_config do
  desc 'Test site config in application_config.yml'
  task :test => [:environment] do
    if SiteConfig.instance.valid?
      if SiteConfig.instance.display_configs.size > 0
        puts '  display_types: ' + SiteConfig.instance.display_configs.keys.join(',')
      end
      puts "*****************************************"
      puts "YAY!!! app_config.yml is valid!!!"
    else
      puts SiteConfig.instance.errors.join("\n")
    end
  end
end
