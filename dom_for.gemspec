$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dom_for/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dom_for"
  s.version     = DomFor::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DomFor."
  s.description = "TODO: Description of DomFor."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.17"

  s.add_development_dependency "sqlite3"
end
