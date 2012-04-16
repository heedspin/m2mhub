source 'http://rubygems.org'

gem 'rails', '3.1.3' #'3.2.1'
gem 'json'
gem 'jquery-rails'
gem 'mysql', '2.8.1'
gem 'tiny_tds', '0.5.1'
gem 'activerecord-sqlserver-adapter', '3.1.5' # '3.2.0'

gem 'authlogic', '3.1.0'

gem 'daemons', '1.1.8'
# gem 'crack', '0.1.8'

gem 'formtastic', '2.0.2'
gem 'declarative_authorization', '0.5.5'
gem 'aws-sdk', '1.3.4'
gem 'paperclip', '2.7.0'
gem 'will_paginate', '3.0.3'
gem 'delayed_job', '3.0.1'
gem "airbrake", '3.0.9'
#gem 'thinking-sphinx', '1.3.20', :require => 'thinking_sphinx'
#gem 'ts-delayed-delta', '1.1.0', :require => 'thinking_sphinx/deltas/delayed_delta'
gem 'active_hash' #, '0.9.1'
# No rails 3 love: gem 'userstamp', '2.0.1'
# gem 'composite_primary_keys', '4.1.2'
gem 'spreadsheet', '0.6.8'
gem 'lighthouse-api', '2.0'
gem 'addressable', '2.2.6'
gem 'amatch'
gem 'hominid' # mailchimp


# Sadly this is the best approach until we turn M2MHub into an engine:
# puts Dir.get_cwd
if File.exists?('../doogle')
  gem 'doogle', :path => '../doogle'
elsif File.exists?('../../Dropbox/p/doogle')
  gem 'doogle', :path => '../../Dropbox/p/doogle'
elsif Dir.getwd.include?('lxd')
  gem 'doogle', :git => 'git@github.com:heedspin/doogle.git'
end

group :development do
  gem 'mongrel'
  gem 'ruby-debug'
  gem 'ruby-debug-base'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
end

group :test do
  gem 'factory_girl', '2.5.1'
  gem 'transactional-factories', '0.5.0'
end
