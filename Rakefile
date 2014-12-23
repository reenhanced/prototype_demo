#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Prototype::Application.load_tasks

unless Rails.env.staging?
  desc 'Run factory specs.'
  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = './spec/factories_spec.rb'
  end

  task spec: :factory_specs
end

task default: [:spec, :cucumber]
