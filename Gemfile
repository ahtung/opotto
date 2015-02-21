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
gem 'shoulda'
gem 'newrelic_rpm'
gem 'unicorn'
gem 'money-rails'
gem 'google_contacts_api'
gem 'rails-assets-select2'
gem 'omniauth-google-oauth2'
gem 'rack-google-analytics'
gem 'sidekiq'
gem 'sinatra'
gem 'date_time_attribute'
gem 'validates_timeliness', '~> 3.0'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'brakeman', require: false
  gem 'yard', require: false
  gem 'yard-rspec', require: false
  gem 'mailcatcher'
end

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'poltergeist'
end

group :test do
  gem 'capybara-select2', github: 'goodwill/capybara-select2'
  gem 'shoulda-matchers', require: false
  gem 'pullreview-coverage', require: false
  gem 'test_after_commit', require: false
  gem 'rspec-sidekiq', require: false
end