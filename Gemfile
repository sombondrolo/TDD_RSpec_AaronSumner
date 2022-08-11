source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.10' # July 12, 2016
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '1.3.13' # January 04, 2017
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass', '~> 3.1.1'

gem 'rake', '< 11.0' # 10.5.0 - January 13, 2016

group :development, :test do
  gem "rspec-rails", "~> 3.1.0"
  gem "factory_girl_rails", "~> 4.4.1"

  gem 'guard-rspec', '4.7.3'
  gem 'spring-commands-rspec', '~> 1.0.2'
end

group :test do
  gem "faker", "~> 1.4.3"
  gem "capybara", "~> 2.4.3"
  gem "database_cleaner", "~> 1.3.0"
  gem "launchy", "~> 2.4.2"
  # gem "selenium-webdriver", "~> 2.43.0" # unable to obtain stable firefox connection in 60 seconds (127.0.0.1:7055)
  # gem "selenium-webdriver", '2.53.4'
  # gem "selenium-webdriver", "~> 3.0.0" # Unable to find Mozilla geckodriver
  gem "selenium-webdriver", '3.14.1'   # Unable to find Mozilla geckodriver
  # gem "selenium-webdriver", '4.3.0'    # which depends on ruby (>= 2.7)
  gem 'webdrivers', '3.4.3'
end