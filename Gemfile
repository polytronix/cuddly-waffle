source 'http://rubygems.org'

ruby '3.0.2'
gem 'rails', '~> 6.0.4'
gem 'sass-rails', '>= 5'
#gem 'sassc'
gem 'jquery-rails'
gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'uglifier', '~> 4.1', '>= 4.1.17'
gem 'responders', '~> 3.0.0'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
# gem 'newrelic_rpm', '~> 5.3', '>= 5.3.0.346' Error Issue Rails 6.0.4.1
gem 'ransack' #search function
gem 'nokogiri', '~> 1.10', '>= 1.10.8' 

gem 'pg', '~> 1.0'
gem 'highcharts-rails', '~> 6.0', '>= 6.0.3'
gem 'kaminari', '~> 1.2', '>= 1.2.1'
gem 'simple_calendar', '~> 1.1.10'
gem 'rqrcode', '~> 0.10.1'
gem 'jbuilder', '~> 2.7'
gem 'pg_search', '~> 2.1', '>= 2.1.2'
gem 'bootstrap-datepicker-rails', '~> 1.8', '>= 1.8.0.1'
gem 'sentry-raven', '~> 2.7', '>= 2.7.4'
gem 'sorted', '~> 2.2'
# Reduce boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4', '>= 1.4.6'

gem 'puma', '~> 5.0', '>= 5.0.4'


# gem 'rspec' #test coverage
#this is used for the table print of database
gem 'table_print', '~> 1.5', '>= 1.5.6'
gem "awesome_print", require:"ap"

# gem 'rack-timeout' # used to timeout puma requests
group :development do 
  gem 'listen', '3.5.0'
  gem 'better_errors'
  gem 'pry'
  gem 'pry-byebug'
  gem 'binding_of_caller'
  gem 'bullet'
end

gem 'honeybadger' #tracking and reporting errors triggered by application

group :production do
  # gem 'rails_12factor'
  gem 'rails_12factor', '~> 0.0.3'
  gem 'rack-timeout', '~> 0.5.1'
end

# gem 'simplecov', require: false, group: :test