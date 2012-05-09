require 'rails/generators'
require 'rails/generators/migration'

class M2mhubGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path(File.join(File.dirname(__FILE__), '../..'))

  # Every method that is declared below will be automatically executed when the generator is run
  def copy_migration_files
    Dir.glob(File.join(M2mhubGenerator.source_root, 'db/migrate/*')).each do |source|
      destination = File.join(Rails.root, 'db/migrate', File.basename(source))
      puts "    \e[1m\e[34mcopying\e[0m  #{source} to #{destination}"
      copy_file source, destination
    end
  end

  def copy_assets
    %w(images javascripts stylesheets).each do |asset_subdir|
      copy_asset_directory(File.join(M2mhubGenerator.source_root, "public/#{asset_subdir}/m2mhub"))
    end
  end
  
  def copy_config
    %w(app_config.yml local_config.yml authorization_rules.rb routes.rb).each do |file|
      source = File.join(M2mhubGenerator.source_root, 'config', file)
      destination = source.sub(M2mhubGenerator.source_root, Rails.root)
      unless File.exists?(destination)
        copy_file source, destination
      end
    end
    %w(main_config.yml m2mhub_config.yml).each do |file|
      source = File.join(M2mhubGenerator.source_root, 'config', file)
      destination = source.sub(M2mhubGenerator.source_root, Rails.root)
      copy_file source, destination
    end
  end

  private

    def copy_asset_directory(asset_directory)
      Dir.glob(File.join(asset_directory, '*')).each do |source|
        destination = source.sub(M2mhubGenerator.source_root, Rails.root)
        if File.directory?(source)
          copy_asset_directory(source)
        else
          unless File.exists?(destination)
            puts "    \e[1m\e[34mcopying\e[0m  #{source} to #{destination}"
            copy_file source, destination
          end
        end
      end
    end
end
