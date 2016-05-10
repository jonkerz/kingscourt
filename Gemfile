source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '>= 5.0.0.beta4', '< 5.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'

gem 'bower-rails', '~> 0.10.0'
gem 'slim-rails'
gem 'slim', require: 'slim/smart'
gem 'angular-rails-templates'
gem 'activeadmin', github: 'activeadmin'
gem 'active_model_serializers',
  github: "rails-api/active_model_serializers"
  # http://stackoverflow.com/questions/34507596/undefined-method-config-for-activemodelserializer
gem 'devise_token_auth',
  github: "lynndylanhurley/devise_token_auth",
  branch: "master"
  # https://github.com/lynndylanhurley/devise_token_auth/issues/500
gem 'colorize'
gem 'clean_pagination'
gem 'mysql2'
gem 'ngannotate-rails'

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'quiet_assets'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
