ENV['RAILS_ENV'] ||= 'test'

# Coverage
# require 'codeclimate-test-reporter'
# CodeClimate::TestReporter.start
require 'simplecov'
SimpleCov.start 'rails'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/poltergeist'
require 'money-rails/test_helpers'
require 'sidekiq/testing'
require 'pundit/rspec'
require 'database_cleaner'

# Enable Capyara
Capybara.javascript_driver = :poltergeist

Warden.test_mode!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include AuthenticationHelpers
  config.include FactoryGirl::Syntax::Methods
  config.include MoneyRails::TestHelpers
  config.include Warden::Test::Helpers
  config.include AbstractController::Translation
  config.include ActionView::Helpers::NumberHelper
  config.include ActionView::Helpers::DateHelper
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  config.before(:each) do |example|
    Sidekiq::Worker.clear_all
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end