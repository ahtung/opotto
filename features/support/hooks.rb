require 'capybara/poltergeist'
if ENV['RACK_ENV'] == 'production'
  Capybara.app_host = 'http://www.opotto.com'
else
  Capybara.app_host = 'http://opotto-staging.herokuapp.com'
end
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    window_size: [1280, 1024]
  )
end
Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
