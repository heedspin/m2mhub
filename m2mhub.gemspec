$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "m2mhub/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "m2mhub"
  s.version     = M2mhub::VERSION
  s.authors     = ["Tim Harrison"]
  s.email       = ["heedspin@gmail.com"]
  s.homepage    = "https://github.com/heedspin/m2mhub"
  s.summary     = "Web access to Made2Manage"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.mdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '3.1.10'
  s.add_dependency 'json', '1.6.6'
  s.add_dependency 'jquery-rails', '1.0.19'
  # s.add_dependency 'mysql', '2.8.1'
  # s.add_dependency 'tiny_tds', '0.5.1'
  # s.add_dependency 'activerecord-sqlserver-adapter', '3.1.5' # '3.2.0'
  s.add_dependency 'authlogic', '~> 3.1.0'
  s.add_dependency 'daemons', '1.1.8'
  s.add_dependency 'formtastic', '2.0.2'
  s.add_dependency 'declarative_authorization', '0.5.5'
  s.add_dependency 'will_paginate', '~> 3.0.3'
  s.add_dependency 'delayed_job_active_record', '~> 0.3.2'
  s.add_dependency "airbrake"
  s.add_dependency 'active_hash', '~> 0.9.9'
  s.add_dependency 'spreadsheet', '0.7.4'
  s.add_dependency 'lighthouse-api', '2.0'
  s.add_dependency 'addressable', '2.2.6'
  s.add_dependency 'amatch', '0.2.10'
  s.add_dependency 'hominid', '3.0.4'
end
