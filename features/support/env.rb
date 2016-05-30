require "cucumber/rails"
require "paper_trail/frameworks/cucumber"
require "sunspot_test/cucumber"

if ENV["HEADLESS"]
  require "headless"

  headless = Headless.new
  headless.start

  at_exit do
    headless.destroy
  end
end

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.default_driver = :webkit

Capybara.javascript_driver = :webkit
if ENV["DRIVER"] == "selenium" || ENV["SEL"] || ENV["SSS"] || ENV["SSP"]
  # "Single Step Selenium"
  # "Single Step Pry"
  puts "Enabling selenium driver..."
  Capybara.javascript_driver = :selenium
end

Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }

Capybara::Webkit.configure(&:block_unknown_urls)

World FactoryGirl::Syntax::Methods
