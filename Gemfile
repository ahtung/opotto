source 'https://rubygems.org'

ruby '2.2.4'

gem 'rails', '5.0.0'
gem 'iyzipay', '~> 1.0.34', require: false
gem 'rake', '11.2.2'
gem 'sass-rails', '~> 5.0.1'
gem 'pg', '~> 0.18.4'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'foreman', '~> 0.82.0'
gem 'slim-rails'
gem 'devise', github: 'plataformatec/devise'
gem 'puma', '~> 3.5.2'
gem 'money-rails', '~> 1.6.0'
gem 'google_contacts_api', '~> 0.7.0'
gem 'omniauth-google-oauth2', '~> 0.4.1'
gem 'rack-google-analytics', '~> 1.2.0'
gem 'sidekiq', '~> 4.1.1'
gem 'sinatra', github: 'sinatra'
gem 'date_time_attribute', '~> 0.1.2'
gem 'validates_timeliness', '~> 4.0.2'
gem 'pundit', '~> 1.1.0'
gem 'http_accept_language', '~> 2.0.5'
gem 'high_voltage', '~> 3.0.0'
gem 'gaffe', '~> 1.1.0'
gem 'paperclip', '~> 4.3.6'
gem 'semantic-ui-sass', github: 'ahtung/semantic-ui-sass'
gem 'nav_lynx'
gem 'browser', '~> 2.1.0'
gem 'browser-timezone-rails', '~> 1.0'
gem 'factory_girl_rails'
gem 'devise-i18n', '~> 1.1.0'
gem 'roboto', '~> 0.2.0'
gem 'fog-aws', '~> 0.10.0'
gem 'sitemap_generator'
gem 'rails-i18n'
gem 'net-ssh', '~> 3.2.0'
gem 'state_machines-activerecord'
gem 'faker'
gem 'rack-attack', '~> 4.4.1'
gem 'meta-tags', '~> 2.1.0', require: 'meta_tags'
gem 'rollbar', '~> 2.12.0'
gem 'bullet'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'draper', '~> 3.0.0.pre1'
gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml'

group :production do
  gem 'rails_12factor'
  gem 'skylight', '~> 0.10.0'
end

group :development do
  gem 'scss_lint', require: false
  gem 'squasher'
  gem 'brakeman', require: false
  gem 'yard', require: false
  gem 'yard-rspec', require: false
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
  gem 'coveralls', require: false
  gem 'timecop'
  gem 'codeclimate-test-reporter', require: false
  gem 'rspec-its'
  gem 'state_machine_rspec'
  gem 'poltergeist'
  gem 'webmock'
  gem 'rspec_junit_formatter', '~> 0.2.3'
  gem 'rails-controller-testing'
end
