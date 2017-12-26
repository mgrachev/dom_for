# coding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'dom_for/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'dom_for'
  s.version     = DomFor::VERSION
  s.authors     = ['Mikhail Grachev']
  s.email       = ['work@mgrachev.com']
  s.homepage    = 'https://github.com/mgrachev/dom_for'
  s.summary     = 'Helper for creating HTML wrappers ActiveRecord objects.'
  s.description = 'Helper for easy creation of HTML wrapper ActiveRecord objects.'
  s.license     = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', '>= 3.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'yard', '~> 0.9.11'
  s.add_development_dependency 'redcarpet', '~> 3.0' # Markdown implementation (for yard)
  s.add_development_dependency 'rubocop'
end
