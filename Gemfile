source "https://rubygems.org"
ruby "2.2.2"

gem "rails", ">= 5.0.0.beta4", "< 5.1"

gem "coffee-rails", "~> 4.1.0"
gem "execjs"
gem "jbuilder", "~> 2.0"
gem "jquery-rails"
gem "less-rails" # For Bootstrap
gem "mysql2"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "slim-rails"
gem "therubyracer"
gem "uglifier", ">= 1.3.0"

# Misc.
gem "colorize"
gem "dotenv-rails"
gem "paper_trail"

# Angular
gem "angular-rails-templates"
gem "autoprefixer-rails"
gem "bower-rails", "~> 0.10.0"
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

# Admin backend
gem "activeadmin", github: "activeadmin"
gem "kaminari",
  github: "amatsuda/kaminari",
  branch: "0-17-stable"
  # https://github.com/sferik/rails_admin/issues/2628

group :development do
  gem "capistrano", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano3-puma", require: false
  gem "listen", "~> 3.0.5"
  gem "quiet_assets"
  gem "rubocop", "~> 0.40.0", require: false
  gem "sunspot_solr", "2.2.0"
  gem "web-console"
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
end
