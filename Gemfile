source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.2'


gem 'rails', '4.2.0'
gem 'foundation-rails', '~> 5.5.0'
gem 'sass-rails', '~> 5.0.1'
gem 'pg'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'foreman'
gem 'slim-rails'
gem 'devise'
gem 'newrelic_rpm'                      # NewRelic
gem 'unicorn'
gem 'money-rails'
gem 'google_contacts_api'
gem 'rails-assets-select2'              # Select2.js
gem 'rails-assets-d3'                   # D3.js
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
  gem 'cane'                              # TODO
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'faker'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'poltergeist'
end

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'capybara-select2', github: 'goodwill/capybara-select2'
  gem 'shoulda-matchers', require: false
  gem 'test_after_commit', require: false
  gem 'rspec-sidekiq'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
  gem 'rspec-its'
end