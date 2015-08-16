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
  fail "Must pass a hash containing 'from'" if !options.is_a?(Hash) || !options.key?(:from)
  label = first('label', text: options[:from])
  fail "No label that contains '#{label}' found" unless label
  if options[:multi]
    select2_multi(options[:from], value)
  else
    select2_normal(label, value)
  end
end

def select2_multi(from, value)
  # FIXME: Use capybara methods instead of JS
  page.execute_script <<-JS
    $('label:contains("#{from}")').parent().find('input.select2-offscreen').select2('data', {text: '#{value}'}, true);
  JS
end

def select2_normal(label, value)
  container = label.find(:xpath, '..').find('.select2-container')
  container.find('.select2-choice').click
  find(:xpath, '//body').find('.select2-drop li', text: value).click
end

def fill_in_jar_form(jar)
  fill_in 'jar_name', with: jar.name
  select2 'onurkucukkece@gmail.com', from: t('jar.receiver')
  select2 'us-personal@gmail.com', multi: true, from: t('activerecord.attributes.jar.guest_ids')
  fill_in 'jar_description', with: jar.description
  fill_in 'jar_end_at_date', with: Time.zone.now + 10.days
  fill_in 'jar_end_at_time', with: Time.zone.now + 10.days
  check 'jar_visible'
  fill_in 'jar_upper_bound', with: jar.upper_bound
end
