source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.2.3'
gem 'foundation-rails', '~> 5.5.0'
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
gem 'newrelic_rpm'                      # NewRelic
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
gem 'high_voltage', '~> 2.2.1'          # Static Pages
gem 'gaffe'                             # Errors
gem 'pp-adaptive'
gem 'paypal-sdk-adaptiveaccounts'
gem 'browser-timezone-rails'
gem 'rubocop'
gem 'cane'
gem 'factory_girl_rails'
gem 'devise-i18n'
gem 'roboto'
gem 'fog'
gem 'sitemap_generator'
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x
gem 'i18n-tasks', '~> 0.8.2'
gem 'net-ssh', '~> 2.9.2'
gem 'state_machine', '~> 1.2.0'

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
  gem 'faker'
  gem 'shoulda'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'shoulda-matchers', require: false
  gem 'test_after_commit', require: false
  gem 'rspec-sidekiq'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
  gem 'rspec-its'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-select2'              # Select2.js
  gem 'rails-assets-d3'                   # D3.js
end
