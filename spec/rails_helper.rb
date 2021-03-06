ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter])
SimpleCov.start 'rails' do
  add_group 'Policies', 'app/policies'
  add_group 'Decorators', 'app/decorators'
end
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'money-rails/test_helpers'
require 'pundit/rspec'
require 'database_cleaner'
require 'webmock/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end
Capybara.javascript_driver = :poltergeist

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
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include AbstractController::Translation
  config.include ActionView::Helpers::NumberHelper
  config.include ActionView::Helpers::DateHelper
  config.include StateMachineRspec::Matchers
  config.include OmniauthMacros
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  WebMock.disable_net_connect!(allow_localhost: true)

  config.before(:each) do
    stub_request(:post, 'https://accounts.google.com/o/oauth2/token')
      .to_return(status: 200, body: {
        access_token: 'ya29.1wG-l4jjtF6OOEmCf7RB6w07UheAcEkdEj2fJ52tOZzK_kDd8J400PCBmWU7BzgqUQqa',
        token_type: 'Bearer',
        expires_in: 3600,
        refresh_token: '1/L7S-j2AOqJLQE3kYAsiFKVtykz3sAYhx2XOiuCjTce9IgOrJDtdun6zK6XiATCKT'
      }.to_json, headers: {})
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

  config.after(:each) do
    I18n.locale = :en
  end

  config.before(:suite) do
    Warden.test_mode!
  end
end
