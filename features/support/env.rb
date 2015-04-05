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

  # the symbol passed to mock_auth is the same as the name of the provider set up in the initializer
  OmniAuth.config.add_mock(:google_oauth2, {
    uid: '12345',
    refresh_token: '12345',
    info: {
      name: 'twitteruser',
      email: "test@xxxx.com"
    }
  })
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end