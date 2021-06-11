# Rake is a utility for defining and running tasks that are requires ass part of
# building and running an application
#
# https://github.com/ruby/rake
#
task :default => ["syntax"]

# This task should run a bunch of sub-tasks that validate syntax
desc "Runs syntax validation"
task :syntax do
  Rake::Task[:'syntax:ruby'].invoke
end

# All syntax checking tasks should go here
namespace :syntax do
  task :ruby do
    Dir['jobs/*.rb'].each do |file|
      sh "ruby -c #{file}"
    end
  
    Dir['dashboards/*.erb'].each do |file|
      sh "erb -x -T '-' #{file} | ruby -c"
    end
  end
end
