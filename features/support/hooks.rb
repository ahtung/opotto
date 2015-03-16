require 'capybara/poltergeist'
Capybara.app_host = 'http://opotto-staging.herokuapp.com'
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      window_size: [1280, 1024]#,
      #debug:       true
    )
  end
Capybara.default_driver    = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
