require "dotenv"
Dotenv.load

require "capistrano/setup"
require "capistrano/deploy"

require "capistrano/rails"
require "capistrano/rake"
require "capistrano/bundler"
require "capistrano/rvm"
require "capistrano/puma"
require "capistrano/rails/assets"
require "capistrano/faster_assets"
require "capistrano/rails/console"
require "capistrano-pending"
require "capistrano-db-tasks"

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
