
require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rake/testtask'

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty --tags ~@future_release"
end

Cucumber::Rake::Task.new(:debug) do |t|
  t.cucumber_opts = "features --format pretty --tags @debug"
end


Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.pattern = 'test/**/test_*.rb'
  t.warning = true
end

