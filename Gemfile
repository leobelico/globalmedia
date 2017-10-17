source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'sys-proctable'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'pg'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0.5'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'rails-jquery-autocomplete'
gem 'devise'
gem 'foreman'
gem 'aws-sdk', "2.2.8"
gem 'will_paginate', "~>3.0.5"
gem 'autoprefixer-rails'
gem "cancan"
gem 'connection_pool'
gem 'jwt'
gem 'active_model_serializers'
gem 'rack-cors'
gem 'rack-attack'
gem 'simple_command'
gem 'api-pagination', "4.4.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'dalli'
gem "rack-timeout"
gem 'newrelic_rpm'
# gem "skylight"
#gem 'unicorn'
# gem 'actionpack-action_caching'
# gem 'dalli-store-extensions', :git => "git://github.com/defconomicron/dalli-store-extensions.git"
# gem 'resque', require: 'resque/server'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '>= 3.5.0'

end

group :production do  
  gem 'heroku-deflater'
end
# gem 'sys-proctable'
# gem 'memory_profiler'
# gem 'flamegraph'
# gem 'stackprof'     # For Ruby MRI 2.1+
# gem 'fast_stack'    # For Ruby MRI 2.0

group :development do
  gem 'rack-mini-profiler'

  gem 'derailed'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  # gem 'rails_real_favicon'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
