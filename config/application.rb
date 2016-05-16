require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Kingscourt
  class Application < Rails::Application
  end
end
