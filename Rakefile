#!/usr/bin/env rake

require File.expand_path('../config/application', __FILE__)

require 'queue_classic'
require 'queue_classic/tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

Ultimate::Application.load_tasks
