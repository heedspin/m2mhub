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
  
  def copy_asset_directory(asset_directory)
      Dir.glob(File.join(asset_directory, '*')).each do |source|
        if File.directory?(source)
          copy_asset_directory(source)
        else
          destination = source.clone
          destination.sub(File.join(M2mhubGenerator.source_root, 'public'), File.join(Rails.root, 'public'))
          unless File.exists?(destination)
            puts "    \e[1m\e[34mcopying\e[0m  #{source} to #{destination}"
            copy_file source, destination
          end
        end
      end
    end
  end
end
