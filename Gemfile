source "https://rubygems.org"
ruby "2.3.1"

gem "rails", "5.0.7.2"

gem "coffee-rails"
gem "execjs"
gem "jquery-rails"
gem "jquery-ui-rails", "5.0.5"
gem "mysql2"
gem "puma"
gem "sass-rails"
gem "slim-rails"
gem "therubyracer", "0.12.2"
gem "uglifier", "3.0.0"

# Misc.
gem "colorize"
gem "dotenv-rails"
gem "paper_trail", "5.1.1"

# Angular
gem "angular-rails-templates"
gem "autoprefixer-rails", "6.3.6.2"
gem "bower-rails", "0.10.0"
gem "ngannotate-rails"

# API
gem "active_model_serializers", "0.10.0"
gem "devise", "4.0.2"
gem "devise_token_auth",
  github: "lynndylanhurley/devise_token_auth",
  ref: "10863b31270b31cec72a07e1a195aa21686ede2b"
  # https://github.com/lynndylanhurley/devise_token_auth/issues/500
gem "slugify"
gem "sunspot_rails", "2.2.0"
gem "sunspot_solr", "2.2.0"

# Admin backend
gem "activeadmin", "1.4.3"
gem "kaminari"

group :development do
  gem "capistrano", "3.5.0", require: false
  gem "capistrano-rvm", "0.1.2", require: false
  gem "capistrano-rails", "1.1.6", require: false
  gem "capistrano-rake", "0.1.0", require: false
  gem "capistrano-bundler", "1.1.4", require: false
  gem "capistrano3-puma", "1.2.1", require: false
  gem "capistrano-faster-assets", "1.0.2", require: false
  gem "capistrano-rails-console", "1.0.2", require: false
  gem "capistrano-pending", "0.1.1", require: false
  gem "capistrano-db-tasks", "0.4", require: false
  gem "listen", "3.1.5"
  gem "rubocop", "~> 0.40.0", require: false
end

group :test do
  gem "capybara", "2.18.0"
  gem "capybara-screenshot"
  gem "capybara-webkit"
  gem "cucumber-rails", "< 2.1.0", require: false # TODO: Locked due to Cucumber 4.
  gem "database_cleaner"
  gem "factory_girl_rails"
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
