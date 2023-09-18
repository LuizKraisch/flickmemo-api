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

    config.active_record.encryption.primary_key = ENV.fetch('ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY', nil)
    config.active_record.encryption.deterministic_key = ENV.fetch('ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY', nil)
    config.active_record.encryption.key_derivation_salt = ENV.fetch('ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT', nil)

    config.time_zone = 'UTC'

    config.api_only = true
  end
end
