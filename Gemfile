source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.2.5'
# gem 'materialize-sass'
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
gem 'money-rails'
gem 'google_contacts_api'
gem 'omniauth-google-oauth2'
gem 'rack-google-analytics'             # Google Analytics
gem 'sidekiq'                           # Background Jobs
gem 'sinatra'
gem 'date_time_attribute'
gem 'validates_timeliness', '~> 3.0'
gem 'pundit'                            # Authorization
gem 'http_accept_language'
gem 'high_voltage', '~> 2.4.0'          # Static Pages
gem 'gaffe'                             # Errors
gem 'pp-adaptive'
gem 'paypal-sdk-adaptiveaccounts'
gem 'browser-timezone-rails'
gem 'rubocop'
gem 'cane'
gem 'factory_girl_rails'
gem 'devise-i18n'
gem 'roboto'
gem 'fog-aws'
gem 'sitemap_generator'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x
gem 'i18n-tasks', '~> 0.9.2'
gem 'net-ssh', '~> 2.9.2'
gem 'state_machines-activerecord','~> 0.3.0'
gem 'mapbox-rails'
gem 'faker'
gem 'rack-attack'
gem 'meta-tags', '~> 1.5.0', require: 'meta_tags'
gem 'skylight', '~> 0.10.0'
gem 'rollbar', '~> 2.4.0'

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
  gem 'byebug'
  gem 'web-console', '~> 2.0'
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

source 'https://rails-assets.org' do
  gem 'rails-assets-select2', '~> 4.0.0'
  gem 'rails-assets-materialize'
end
