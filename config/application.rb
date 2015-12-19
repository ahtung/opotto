require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Opotto
module Opotto
  # Application
  class Application < Rails::Application
    config.i18n.available_locales = [:tr, :en]
    config.generators.helper = false
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.i18n.available_locales = [:tr, :nl, :en]
    config.middleware.use Rack::Attack
    # config.i18n.default_locale = :tr
  end
end
