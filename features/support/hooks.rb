require 'capybara/poltergeist'
# if ENV['RAILS_ENV'] == 'production'
#   Capybara.app_host = 'http://www.opotto.com'
#   Capybara.run_server = false
# elsif ENV['RACK_ENV'] == 'staging'
#   Capybara.app_host = 'http://opotto-staging.herokuapp.com'
#   Capybara.run_server = false
# else
#   Capybara.app_host = 'http://localhost:3000'
#   Capybara.run_server = true
# end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    window_size: [1280, 1024]
  )
end

Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
