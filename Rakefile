#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

YARD::Rake::YardocTask.new

Bundler::GemHelper.install_tasks