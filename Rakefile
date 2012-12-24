require "bundler/gem_tasks"
require 'rake/testtask'

$:.push File.expand_path(File.dirname(__FILE__), 'lib')

desc 'Test better_robots'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_*spec.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

task :default => :test