#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Pcms::Application.load_tasks

namespace :test do
  desc "Test lib source"
  Rake::TestTask.new(:lib) do |t|    
    t.libs << "test"
    t.pattern = 'test/lib/**/*_test.rb'
  end
end

Rake::Task[:test].enhance { Rake::Task["test:lib"].invoke }
