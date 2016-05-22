source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0.1'
gem 'pg', '~> 0.18.4'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails', '~> 4.1.1'
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'foreman', '~> 0.82.0'
gem 'slim-rails', '~> 3.0.1'
gem 'devise', '~> 3.5.3'
gem 'puma', '~> 3.4.0'
gem 'money-rails', '~> 1.6.0'
gem 'google_contacts_api', '~> 0.7.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'
gem 'rack-google-analytics', '~> 1.2.0'
gem 'sidekiq', '~> 4.1.1'
gem 'sinatra'
gem 'date_time_attribute', '~> 0.1.2'
gem 'validates_timeliness', '~> 4.0.2'
gem 'pundit', '~> 1.1.0'
gem 'http_accept_language', '~> 2.0.5'
gem 'high_voltage', '~> 3.0.0'
gem 'gaffe', '~> 1.1.0'
gem 'paperclip', '~> 4.3.6'
gem 'pp-adaptive', '~> 1.0.0'
gem 'paypal-sdk-adaptiveaccounts', '~> 1.102.1'
gem 'browser-timezone-rails', '~> 0.0.8'
gem 'factory_girl_rails', '~> 4.7.0'
gem 'devise-i18n', '~> 1.0.1'
gem 'roboto', '~> 0.2.0'
gem 'fog-aws', '~> 0.9.2'
gem 'sitemap_generator'
gem 'rails-i18n', '~> 4.0.8'
gem 'net-ssh', '~> 3.1.1'
gem 'state_machines-activerecord','~> 0.4.0'
gem 'faker'
gem 'rack-attack', '~> 4.4.1'
gem 'meta-tags', '~> 2.1.0', require: 'meta_tags'
gem 'rollbar', '~> 2.11.0'
gem 'rubocop'
gem 'cane'
gem 'bullet', '~> 5.1.0'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'draper', '~> 2.1.0'
gem 'semantic-ui-sass', github: 'ahtung/semantic-ui-sass'
gem 'nav_lynx'

group :production do
  gem 'rails_12factor'
  gem 'skylight', '~> 0.10.0'
end

group :development do
  gem 'squasher'
  gem 'brakeman', require: false
  gem 'yard', require: false
  gem 'yard-rspec', require: false
  gem 'mailcatcher'
  gem 'i18n-tasks', '~> 0.9.4'
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
  gem 'rspec_junit_formatter', '~> 0.2.3'
end
