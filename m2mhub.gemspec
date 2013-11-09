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

  s.add_dependency 'rails', '3.2.13'
  # s.add_dependency 'json'#, '1.6.6'
  s.add_dependency 'daemons', '1.1.8'
  s.add_dependency 'declarative_authorization', '0.5.7'
  # s.add_dependency 'will_paginate', '~> 3.0.4'
  s.add_dependency 'active_hash', '~> 1.0.0'
  s.add_dependency 'spreadsheet', '0.8.4'
  s.add_dependency 'addressable', '2.2.6'
  s.add_dependency 'amatch', '0.2.11'
  s.add_dependency 'hominid', '3.0.4'
end
