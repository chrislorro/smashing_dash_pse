source 'https://rubygems.org'

# Also having to use a custom fork of smashing sine it's dependencies are too
# tight to allow for thin 1.8.0. This can be changed back to the gem version
# once this PR is merged: https://github.com/Smashing/smashing/pull/178
gem 'smashing',
  git: 'https://github.com/dylanratcliffe/smashing.git',
  branch: 'dependencies'

gem 'puppet_forge'

# Development dependencies. These are specified as a group so that they can be
# excluded from production deployments
group :development do
  gem 'readapt'
  gem 'pry'
end