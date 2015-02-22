require 'localeapp/rails'

if Rails.env.development?
  Localeapp.configure do |config|
    config.api_key = ENV['LOCALEAPP_API_KEY']
  end
end
