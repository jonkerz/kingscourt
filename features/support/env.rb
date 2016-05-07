require 'cucumber/rails'

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :transaction
Cucumber::Rails::Database.javascript_strategy = :truncation
Capybara.default_driver = :webkit
Capybara.save_and_open_page_path = "tmp/capybara"

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
  config.allow_url "192.168.1.74" # old API server (Django)
end
