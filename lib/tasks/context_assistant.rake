# bundle exec rake context_assistant:chrome
namespace :context_assistant do
  desc 'Create chrome extension package'
  task :chrome => :environment do
    require 'crxmake'
    extension_root = File.join(M2mhub::Engine.root, 'extensions/chrome/context_assistant')
    puts "Packaging: #{extension_root}"
    # create crx
    CrxMake.make(
      :ex_dir => extension_root,
      :pkey   => File.join(extension_root, 'package/context_assistant.pem'),
      :crx_output => File.join(extension_root, 'package/context_assistant.crx'),
      :verbose => true,
      :ignorefile => /\.swp/,
      :ignoredir => /(\.git|package)/
    )
  end

end
