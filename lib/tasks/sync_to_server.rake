class SyncToServer
  def run
    source_base = File.expand_path(File.join(Rails.root, '..'))
    destination_base = AppConfig.sync_to_server_base
    %w(lxdhub m2mhub plutolib).each do |dir|
      command = "rsync -va --exclude=.git #{source_base}/#{dir} #{destination_base}"
      # puts "Running: #{command}"
      output = `#{command}`
      if output =~ /building file list \.\.\. done\n(.*?)sent \d+ bytes/m
        file_list = $1.strip
        puts file_list if file_list.present?
      else
        puts output
      end
    end
  end
end

namespace :m2mhub do
  desc 'Runs rsync every 5 seconds to the server destination specified by sync_to_server_base in local_config.yml'
  task 'sync_to_server' do
    require 'signal_handler'
    SignalHandler.instance.register_int_to_shutdown
    puts "Running..."
    while true do
      SyncToServer.new.run
      (1..5).each do
        break if SignalHandler.instance.shutdown?
        sleep 1
      end
      break if SignalHandler.instance.shutdown?
    end
    puts "Finished"
  end
end