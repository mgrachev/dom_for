# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'dom_for/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'dom_for'
  s.version     = DomFor::VERSION
  s.authors     = ['Mikhail Grachev']
  s.email       = ['work@mgrachev.com']
  s.homepage    = 'https://github.com/mgrachev/dom_for'
  s.summary     = 'Easily create DOM HTML wrapper for objects.'
  s.description = 'Easily create DOM HTML wrapper for objects.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']

  #s.files         = `git ls-files -z`.split("\x0")
  #s.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #s.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  #s.require_paths = ['lib']

  s.add_dependency 'rails', '~> 3.2.17'

  s.add_development_dependency 'sqlite3'

  s.add_development_dependency 'rspec-rails'

  s.add_development_dependency 'yard', '~> 0.8.7'
  s.add_development_dependency 'redcarpet', '~> 3.0' # Markdown implementation (for yard)
end