namespace :m2m do
  config_key = "test_m2m"

  desc 'Recreate the test_m2m database'
  task :prepare => :environment do
    unless Rails.env.test?
      raise "Please only run this in test env, and double check the database name.  it will be deleted"
    end
    @charset   = ENV['CHARSET']   || 'utf8'
    @collation = ENV['COLLATION'] || 'utf8_unicode_ci'
    c = ActiveRecord::Base.configurations[config_key] || (raise "Failed to find database.yml config for #{config_key}")
    M2m::Base.connection.drop_database c['database']
    M2m::Base.connection.create_database(c['database'], :charset => (c['charset'] || @charset), :collation => (c['collation'] || @collation))
    M2m::Base.establish_connection(config_key)
    M2m::Base.connection.recreate_database(c["database"], c)
    file = File.join(Rails.root, 'db', 'm2m_schema.rb')
    raise "Failed to find #{file}" unless File.exists?(file)
    M2m::Base.establish_connection(config_key)
    load(file)
  end

end
