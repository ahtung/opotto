source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '4.2.5'
gem 'materialize-sass'
gem 'sass-rails', '~> 5.0.1'
gem 'pg'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails', '~> 4.0.4'
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'foreman'
gem 'slim-rails'
gem 'devise'
gem 'puma'
gem 'money-rails', '~> 1.4.1'
gem 'google_contacts_api', '~> 0.7.0'
gem 'omniauth-google-oauth2', '~> 0.2.10'
gem 'rack-google-analytics', '~> 1.2.0'
gem 'sidekiq'
gem 'sinatra'
gem 'date_time_attribute', '~> 0.1.2'
gem 'validates_timeliness', '~> 3.0'
gem 'pundit', '~> 1.0.1'
gem 'http_accept_language', '~> 2.0.5'
gem 'high_voltage', '~> 2.4.0'
gem 'gaffe', '~> 1.0.2'
gem 'pp-adaptive'
gem 'paypal-sdk-adaptiveaccounts', '~> 1.102.1'
gem 'browser-timezone-rails'
gem 'rubocop'
gem 'cane'
gem 'factory_girl_rails', '~> 4.5.0'
gem 'devise-i18n', '~> 0.12.1'
gem 'roboto', '~> 0.2.0'
gem 'fog-aws', '~> 0.7.6'
gem 'sitemap_generator'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x
gem 'i18n-tasks', '~> 0.9.2'
gem 'net-ssh', '~> 2.9.2'
gem 'state_machines-activerecord','~> 0.3.0'
gem 'mapbox-rails', '~> 1.6.1.1'
gem 'faker'
gem 'rack-attack', '~> 4.3.1'
gem 'meta-tags', '~> 1.5.0', require: 'meta_tags'
gem 'skylight', '~> 0.10.0'
gem 'rollbar', '~> 2.7.0'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'brakeman', require: false
  gem 'yard', require: false
  gem 'yard-rspec', require: false
  gem 'mailcatcher'
  gem 'bullet'
end

group :development, :test do
  gem 'spring'
  gem 'rspec-rails'
  gem 'shoulda'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'pry-remote'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers', require: false
  gem 'test_after_commit', require: false
  gem 'rspec-sidekiq'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
  gem 'rspec-its'
  gem 'state_machine_rspec'
  gem 'webmock'
end
