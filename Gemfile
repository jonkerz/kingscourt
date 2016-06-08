source "https://rubygems.org"
ruby "2.3.1"

gem "rails", ">= 5.0.0.rc1", "< 5.1"

gem "coffee-rails"
gem "execjs"
gem "jbuilder"
gem "jquery-rails"
gem "mysql2"
gem "puma"
gem "sass-rails"
gem "slim-rails"
gem "therubyracer"
gem "uglifier"

# Misc.
gem "colorize"
gem "dotenv-rails"
gem "paper_trail"

# Angular
gem "angular-rails-templates"
gem "autoprefixer-rails"
gem "bower-rails"
gem "ngannotate-rails"

# API
gem "active_model_serializers",
  github: "rails-api/active_model_serializers"
  # http://stackoverflow.com/questions/34507596/undefined-method-config-for-activemodelserializer
gem "devise_token_auth",
  github: "lynndylanhurley/devise_token_auth",
  branch: "master"
  # https://github.com/lynndylanhurley/devise_token_auth/issues/500
gem "slugify"
gem "sunspot_rails", "2.2.0"
gem "sunspot_solr", "2.2.0"

# Admin backend
gem "activeadmin", github: "activeadmin"
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
  gem "listen", "~> 3.0.7"
  gem "quiet_assets"
  gem "rubocop", "~> 0.40.0", require: false
end

group :test do
  gem "capybara-screenshot"
  gem "capybara-webkit"
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "factory_girl_rails"
  gem "headless"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "sunspot_test"
end

group :development, :test do
  gem "rspec-rails"
  gem "pry"
  gem "teaspoon-jasmine"
end
