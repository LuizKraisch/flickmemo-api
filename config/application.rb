# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module FlickmemoApi
  class Application < Rails::Application
    config.load_defaults 7.0

    # Remove unused rails routes
    initializer(:remove_action_mailbox_and_activestorage_routes, after: :add_routing_paths) do |app|
      app.routes_reloader.paths.delete_if { |path| path =~ /activestorage/ }
      app.routes_reloader.paths.delete_if { |path| path =~ /actionmailbox/ }
    end

    config.time_zone = 'UTC'

    config.api_only = true
  end
end
