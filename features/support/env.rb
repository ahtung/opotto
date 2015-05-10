ENV['RAILS_ENV'] ||= 'test'

require 'cucumber/rails'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true
  default = {
    provider: :google_oauth2,
    uuid: '1234',
    info: {
      email: 'foobar@example.com'
    }
  }
  OmniAuth.config.add_mock(:twitter, default)
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
