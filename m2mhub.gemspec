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

  s.add_dependency 'spreadsheet', '0.8.4'
end
