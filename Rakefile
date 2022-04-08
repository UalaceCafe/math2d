# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
end

task default: %i[spec]
