require 'cucumber/rails'
require 'paper_trail/frameworks/cucumber'

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.default_driver = :webkit

Capybara.javascript_driver = :webkit
if ENV['DRIVER'] == 'selenium' || ENV['SEL']
  puts "Enabling selenium driver..."
  Capybara.javascript_driver = :selenium
end

Capybara.save_and_open_page_path = "tmp/capybara"
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.allow_url "192.168.1.74" # old API server (Django)
end

World FactoryGirl::Syntax::Methods
