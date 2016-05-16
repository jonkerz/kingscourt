source "https://rubygems.org"
ruby "2.2.2"

gem "rails", ">= 5.0.0.beta4", "< 5.1"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "jbuilder", "~> 2.0"

gem "bower-rails", "~> 0.10.0"
gem "slim-rails"
gem "angular-rails-templates"
gem "activeadmin", github: "activeadmin"
gem "active_model_serializers",
  github: "rails-api/active_model_serializers"
  # http://stackoverflow.com/questions/34507596/undefined-method-config-for-activemodelserializer
gem "devise_token_auth",
  github: "lynndylanhurley/devise_token_auth",
  branch: "master"
  # https://github.com/lynndylanhurley/devise_token_auth/issues/500
gem "colorize"
gem "clean_pagination"
gem "mysql2"
gem "ngannotate-rails"
gem "dotenv-rails"
gem "execjs"
gem "therubyracer"
gem "kaminari",
  github: "amatsuda/kaminari",
  branch: "0-17-stable"
  # https://github.com/sferik/rails_admin/issues/2628
gem "less-rails" # For Bootstrap
gem "paper_trail"
gem "slugify"

group :development do
  gem "web-console"
  gem "listen", "~> 3.0.5"
  gem "quiet_assets"
  gem "capistrano", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano3-puma", require: false
  gem "rubocop", "~> 0.40.0", require: false
end

group :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "capybara-webkit"
  gem "capybara-screenshot"
  gem "shoulda-matchers"
  gem "factory_girl_rails"
end

group :development, :test do
  gem "rspec-rails"
  gem "pry"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
