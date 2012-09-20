#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Bridgeway::Application.load_tasks

desc 'Run factory specs.'
RSpec::Core::RakeTask.new(:factory_specs) do |t|
  t.pattern = './spec/factories_spec.rb'
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "--format pretty"
end

RSpec::Core::RakeTask.new(:rspec) do |t|
  t.spec_opts = ["--color"]
end

task spec: :factory_specs
task default: [:spec, :features]
