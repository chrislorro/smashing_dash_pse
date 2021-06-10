task :default => ["syntax"]

desc "Runs syntax validation"
task :syntax do
  Rake::Task[:ruby_syntax].invoke
end

task :ruby_syntax do
  Dir['**/*.rb'].each do |file|
    sh "ruby -c #{file}"
  end

  Dir['**/*.erb'].each do |file|
    sh "erb -x -T '-' #{file} | ruby -c"
  end
end
