# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module FlickmemoApi
  class Application < Rails::Application
    config.load_defaults 7.0

    config.time_zone = 'Central Time (US & Canada)'

    config.api_only = true
  end
end
