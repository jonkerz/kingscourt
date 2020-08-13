source "https://rubygems.org"
ruby "2.6.6"

gem "rails", "5.2.4.3"

gem "coffee-rails"
gem "execjs"
gem "jquery-rails"
gem "jquery-ui-rails", "5.0.5"
gem "mysql2"
gem "puma"
gem "sass-rails"
gem "slim-rails"
gem "uglifier"

# Misc.
gem "colorize"
gem "dotenv-rails"
gem "paper_trail", "10.3.1"

# Angular
gem "angular-rails-templates"
gem "bower-rails"
gem "ngannotate-rails"

# API
gem "active_model_serializers"
gem "devise"
gem "devise_token_auth"
gem "slugify"
gem "sunspot_rails"
gem "sunspot_solr", "2.2.0"

# Admin backend
gem "activeadmin", "1.4.3"
gem "kaminari"

group :development do
  gem "capistrano", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-rake", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano3-puma", require: false
  gem "capistrano-faster-assets", require: false
  gem "capistrano-rails-console", require: false
  gem "capistrano-pending", require: false
  gem "capistrano-db-tasks", require: false
  gem "listen"
  gem "rubocop", "~> 0.89.1", require: false
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "capybara-webkit"
  gem "cucumber-rails", "< 2.1.0", require: false # TODO: Locked due to Cucumber 4.
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "headless"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "sunspot_test", "0.4.0"
end

group :development, :test do
  gem "rspec-rails"
  gem "pry"
  gem "teaspoon-jasmine"
end
