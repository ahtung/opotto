ENV['RAILS_ENV'] ||= 'test'

require 'cucumber/rails'

include FactoryGirl::Syntax::Methods
include Warden::Test::Helpers
include AbstractController::Translation

Warden.test_mode!

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation

def select2(value, options)
  raise "Must pass a hash containing 'from'" if not options.is_a?(Hash) or not options.has_key?(:from)
  label = first('label', text: options[:from])
  raise "No label that contains '#{ label }' found" unless label
  if options[:search]
    # Open the search field
    label.find(:xpath, '..').find('.select2-container .select2-search-field').click
    # Enter a value
    label.find(:xpath, '..').find('.select2-container .select2-search-field input').set value
    # FIXME wait for the results from the server
    sleep 1
    # Click on the first match
    find(:xpath, "//body").find('.select2-drop li').click
  elsif options[:create]
    # Open the search field
    label.find(:xpath, '..').find('.select2-container a').click
    # Enter a value
    find(:xpath, "//body").find('.select2-drop-active.select2-with-searchbox input').set value
    # FIXME wait for the results from the server
    sleep 1
    # Click on the first match
    find(:xpath, "//body").find('.select2-drop li').click
  elsif options[:multi]
    # FIXME Use capybara methods instead of JS
    page.execute_script <<-JS
      $('label:contains("#{ options[:from] }")').parent().find('input.select2-offscreen').select2('data', { text: '#{ value }' }, true);
    JS
  else
    container = label.find(:xpath, '..').find('.select2-container')
    container.find('.select2-choice').click
    find(:xpath, '//body').find('.select2-drop li', text: value).click
  end
end