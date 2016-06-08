Teaspoon.configure do |config|
  config.mount_at = "/teaspoon"
  config.root = nil
  config.asset_paths = ["spec/javascripts", "spec/javascripts/stylesheets"]

  config.fixture_paths = ["spec/javascripts/fixtures"]

  config.suite do |suite|
    suite.use_framework :jasmine, "2.3.4"
    suite.matcher = "{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}"
    # suite.javascripts = []
    # suite.stylesheets = ["teaspoon"]
    suite.helper = "spec_helper"
    suite.boot_partial = "boot"
    suite.body_partial = "body"
    # suite.hook :fixtures, &proc{}
    # suite.expand_assets = true
    # suite.js_extensions = [/(\.js)?.coffee/, /(\.js)?.es6/, ".es6.js"]
  end

  # config.suite :targeted do |suite|
  #   suite.matcher = "spec/javascripts/targeted/*_spec.{js,js.coffee,coffee}"
  # end

  # Available: :phantomjs, :selenium, :browserstack, :capybara_webkit
  # Selenium Webdriver:
  #   https://github.com/modeset/teaspoon/wiki/Using-Selenium-WebDriver
  # Capybara Webkit:
  #   https://github.com/modeset/teaspoon/wiki/Using-Capybara-Webkit
  config.driver = :capybara_webkit
  config.driver = :selenium if ENV["DRIVER"] == "selenium"

  # Selenium Webdriver:
  #   https://github.com/modeset/teaspoon/wiki/Using-Selenium-WebDriver
  # Capybara Webkit:
  #   https://github.com/modeset/teaspoon/wiki/Using-Capybara-Webkit
  # config.driver_options = nil
  # config.driver_timeout = 180

  # config.server = nil
  # config.server_host = nil
  # config.server_port = nil
  # config.server_timeout = 20
  # config.fail_fast = true

  # Available: :dot, :clean, :documentation, :json, :junit, :pride,
  #   :rspec_html, :snowday, :swayze_or_oprah, :tap, :tap_y, :teamcity
  # config.formatters = [:dot]
  # config.color = true # formatters

  # config.suppress_log = false
end
