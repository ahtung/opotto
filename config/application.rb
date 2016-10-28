require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Opotto
module Opotto
  # Application
  class Application < Rails::Application
    config.generators.helper = false
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.i18n.available_locales = [:tr, :nl, :en]
    config.i18n.default_locale = :tr unless Rails.env.test?
    config.middleware.use Rack::Attack
    config.nav_lynx.selected_class = 'active'
  end
end
