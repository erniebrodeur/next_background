source 'https://rubygems.org'

gemspec

gem 'bini'

group :development do
  gem "pry"
  gem "guard"
  gem "guard-bundler"
  # gem "guard-rspec"
  # gem "guard-yard"
  gem "guard-shell"
  # gem "guard-livereload"
  gem 'libnotify',  :require => false
  gem 'growl',      :require => false
  gem 'rb-inotify', '~> 0.9.0', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
end

group :test do
  gem "rspec"
  gem "rake"
  gem 'simplecov', :require => false
  gem 'simplecov-rcov', :require => false
end

group :documentation do
	gem 'yard'
	gem 'yard-dm'
	gem 'yard-sinatra'
end
